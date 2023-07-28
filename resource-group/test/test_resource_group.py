import tftest
import pytest

variables1 = {"name": "rg-pyterra"}
variables2 = {"name": "rg-pyterra", "location": "northeurope"}


@pytest.fixture(params=[variables1, variables2])
def plan(request, directory="fixture"):
    variables = request.param
    tf = tftest.TerraformTest(directory)
    tf.setup()
    plan = tf.plan(output=True, tf_vars=variables, use_cache=True)
    return plan


@pytest.fixture(params=[variables1, variables2])
def apply(request, directory="fixture"):
    variables = request.param
    tf = tftest.TerraformTest(directory)
    tf.setup()
    tf.apply(output=True, tf_vars=variables, use_cache=True)
    output = tf.output()
    yield output
    tf.destroy(auto_approve=True, tf_vars=variables, use_cache=True)


def test_plan_variables(plan):
    tf_vars = plan.variables
    assert "name" in tf_vars, "name in not in the tf var plan."
    assert tf_vars["name"] == "rg-pyterra"
    assert "location" in tf_vars, "location is not in tf var plan"
    assert tf_vars["location"] in ["westeurope", "northeurope"]


def test_plan_outputs(plan):
    assert "resource-group" in plan.outputs


def test_apply_outputs(apply):
    name = apply["resource-group"]["name"]
    assert name == "rg-pyterra"
    location = apply["resource-group"]["location"]
    assert location in ["westeurope", "northeurope"]
