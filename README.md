# IBM Cloud Administration Basics - Repository Overview 

## Quick Navigation

- [**IBM Cloud Administration Basics 1**](https://felix-janakow.github.io/IBM-Cloud-Administration-Basics/)
- [**Learning Materials per topic**](https://github.com/felix-janakow/IBM-Cloud-Administration-Basics-1/tree/main/basics-learning-materials)


## Repository Structure

```
TTA-Advantage/
│
├── README.md                       # repository overview
├── .gitignore                      # (internal) git ignore rules
│
├── docs/                           # GitHub Pages Website + configuration
│   ├── index.md                    # main workshop page (bilingual EN/DE)
│   ├── _config.yml                 # jekyll configuration
│   └── screenshots/                # workshop screenshots 
│       ├── IBMCloud_Login.png
│       ├── MFA1:2.png
│       ├── IAM_overview.png
│       └── ...
│
├── basics-learning-materials/      # Basics Learning - Materials
│   └── COS.md                      # COS learnings
│   └── ...
│
├── examples/                       # Example implementations
│   ├── IaC/                        # Infrastructure as Code examples - Terraform
│   ├── IaC-Ansible/                # Ansible automation examples
│   ├── deployable-architecture/    # Deployable architecture example templates
│   └── mini-sample-files/          # Sample files for testing
```

---

### Disclaimer

**Important Notice:** All information, recommendations, and examples provided in this repository are for educational purposes only. Use at your own risk and discretion.

Please carefully review all information and cross-check it with the [official IBM Cloud documentation](https://cloud.ibm.com/docs) before implementing it in production environments. IBM and the authors of this repository assume no liability for any damages or issues that may arise from using the content provided here.