# Deployable Architecture Customization Guide

This deployable architecture is based on the IBM Cloud Code Engine Landing Zone. Follow the steps below to customize it for your use case.

## Required Adjustments

### 1. **ibm_catalog.json**
- **Line 4**: Update `label` with your architecture name
- **Line 5**: Update `name` with your unique identifier (lowercase, hyphens only)
- **Line 22**: Update `short_description` to describe your solution
- **Line 23**: Update `long_description` with detailed information
- **Line 24**: Update `offering_docs_url` to point to your documentation
- **Line 25**: Update `offering_icon_url` with your icon/logo URL
- **Lines 26-46**: Customize `features` to match your architecture capabilities
- **Lines 48-439**: Review and adjust the `flavors` section:
  - Update flavor `label` and `name` (line 50-51)
  - Modify `iam_permissions` based on required services (lines 55-133)
  - Update `dependencies` to match your architecture needs (lines 157-310)
  - Adjust `configuration` parameters (lines 314-406)
  - Update `outputs` to reflect your architecture outputs (lines 409-433)

### 2. **main.tf**
- **Line 2**: Update `source` URL to point to your module location
- **Lines 3-6**: Add/remove variables based on your architecture requirements
- Add any additional module configurations specific to your use case

### 3. **variables.tf**
- Review all variables and adjust defaults to match your requirements
- Add new variables needed for your customizations
- Update descriptions to reflect your architecture specifics

### 4. **outputs.tf**
- Uncomment and customize outputs (lines 5-33) based on what your architecture exposes
- Add additional outputs as needed for your solution

### 5. **automation/** and **github-actions/** directories
- Review CI/CD scripts and adjust for your repository structure
- Update workflow files with your catalog IDs and version information
- Modify validation and publishing scripts as needed

### 6. **toolchain/** directory
- Customize toolchain configuration for your DevOps pipeline
- Update scripts to match your build and deployment process

## Onboarding to IBM Cloud Catalog

Follow the [official documentation](https://cloud.ibm.com/docs/secure-enterprise?topic=secure-enterprise-onboard-da) for:
- Creating a private catalog
- Onboarding your architecture
- Validating and publishing


