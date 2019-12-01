package test

import {
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
}

// Testing the bootstrap-azure module in ../bootstrap-azure
func TestBootstrapAzure(t *testing.T) {
	t.parallel()

	// expect. results go here.
	expectedKeyvaultName :=
	expectedResourceGroupName :=
	expectedSubnet :=
	expectedVirtualNetworkName :=

	// The options we use in our terraform commands for testing
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"example": expectedText,

			// We also can see how lists and maps translate between terratest and terraform.
			"example_list": expectedList,
			"example_map":  expectedMap,
		},

		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"varfile.tfvars"},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}
		
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	actualTextExample := terraform.Output(t, terraformOptions, "example")
	actualTextExample2 := terraform.Output(t, terraformOptions, "example2")
	actualExampleList := terraform.OutputList(t, terraformOptions, "example_list")
	actualExampleMap := terraform.OutputMap(t, terraformOptions, "example_map")

	// Verify we're getting back the outputs we expect
	assert.Equal(t, expectedKeyvaultName, actualTextExample)
	assert.Equal(t, expectedResourceGroupName, actualTextExample2)
	assert.Equal(t, expectedSubnet, actualExampleList)
	assert.Equal(t, expectedVirtualNetworkName, actualExampleMap)
}

