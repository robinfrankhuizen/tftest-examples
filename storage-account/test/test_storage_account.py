import json

import tftest
import pytest

from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient


@pytest.fixture()
def plan(request, directory="fixture"):
    tf = tftest.TerraformTest(directory)
    tf.setup()
    plan = tf.plan(output=True, use_cache=True)
    return plan


@pytest.fixture()
def apply(request, directory="fixture"):
    tf = tftest.TerraformTest(directory)
    tf.setup()
    tf.apply(output=True, use_cache=True)
    output = tf.output()
    yield output
    tf.destroy(auto_approve=True, use_cache=True)


def test_upload_blob(apply):
    storage_account = apply["storage_account"]
    account_url = storage_account["primary_blob_endpoint"]

    storage_container = apply["storage_container"]
    container_name = storage_container["name"]

    default_credential = DefaultAzureCredential()
    blob_service_client = BlobServiceClient(account_url, credential=default_credential)

    blob = "my_blob"
    blob_client = blob_service_client.get_blob_client(
        container=container_name, blob=blob
    )
    data = json.dumps({"project": "tftest"})
    blob_client.upload_blob(data)

    container_client = blob_service_client.get_container_client(container_name)
    blob_list = list(container_client.list_blobs())
    assert len(blob_list) == 1

    uploaded_data = container_client.download_blob(blob, encoding="utf-8").readall()

    assert data == uploaded_data
