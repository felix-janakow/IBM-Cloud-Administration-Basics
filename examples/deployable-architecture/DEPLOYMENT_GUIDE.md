# Deployment Guide

## Prerequisites

Before onboarding this deployable architecture to IBM Cloud Catalog, you need to:

1. **Create a Git Repository**
   - Create a new repository on GitHub, GitLab, or IBM GitLab
   - Initialize it with a README

2. **Upload the Content**
   ```bash
   # Clone your new repository
   git clone <your-repo-url>
   cd <your-repo-name>
   
   # Copy all files from this deployable-architecture folder
   cp -r /path/to/deployable-architecture/* .
   
   # Commit and push
   git add .
   git commit -m "Initial deployable architecture"
   git push origin main
   ```

3. **Create a Release/Tag**
   ```bash
   git tag -a v1.0.0 -m "First release"
   git push origin v1.0.0
   ```

## Onboarding to IBM Cloud Catalog

1. **Access Private Catalog**
   - Go to IBM Cloud Console
   - Navigate to Manage > Catalogs
   - Select your private catalog or create a new one

2. **Add Product**
   - Click "Add" or "Import offering"
   - Select "Deployable architecture"
   - Choose "From a Git repository"

3. **Configure Source**
   - **Repository URL**: Enter your Git repository URL
     - Example: `https://github.com/your-org/your-repo`
   - **Repository type**: Select (GitHub/GitLab/IBM GitLab)
   - **Release/Tag**: Enter the tag you created (e.g., `v1.0.0`)
   - **Path**: Leave empty if files are in root, or specify subdirectory

4. **Validate**
   - The catalog will validate your `ibm_catalog.json`
   - Review any validation errors and fix them
   - Once validated, you can publish to your private catalog

## Alternative: Using IBM Cloud Object Storage

If you prefer not to use Git:

1. Upload `deployable-architecture.tar.gz` to IBM Cloud Object Storage
2. Make the object publicly accessible or use a signed URL
3. Use the COS URL when onboarding to the catalog

## Troubleshooting

### "Could not determine repo type" Error
- **Cause**: Trying to upload a local file instead of using a Git repository
- **Solution**: Follow the Git repository setup steps above

### Validation Errors
- Check that `ibm_catalog.json` is properly formatted
- Ensure all required fields are filled in
- Verify that the Terraform files are valid

### Module Source Issues
- Update `main.tf` line 9 to point to a valid module source
- Options:
  - Git: `git::https://github.com/your-org/module.git?ref=v1.0.0`
  - Registry: `terraform-ibm-modules/module-name/ibm`
  - Local: `./modules/your-module` (for development only)

## Next Steps

After successful onboarding:
1. Test the deployment in a development environment
2. Configure CI/CD pipelines using the automation scripts
3. Share with your team through the private catalog
4. Consider publishing to the public IBM Cloud Catalog