# Contributing to Azure Enterprise Solutions Architecture

Thank you for your interest in contributing to this Azure Center of Excellence repository.

---

## Ways to Contribute

### 1. Report Issues

Found a bug or have a suggestion? [Open an issue](https://github.com/maree217/azure-enterprise-solutions-architecture/issues/new).

**Good issue reports include:**
- Clear description of the problem or suggestion
- Steps to reproduce (for bugs)
- Expected vs actual behavior
- Screenshots or code snippets if relevant

### 2. Submit Pull Requests

Want to fix something or add content? PRs are welcome!

**Before submitting:**
- Check existing issues and PRs to avoid duplicates
- For significant changes, open an issue first to discuss
- Follow the style guidelines below

### 3. Improve Documentation

Documentation improvements are always valuable:
- Fix typos or unclear explanations
- Add examples
- Update outdated information
- Translate content

### 4. Share Use Cases

Have you used these patterns in production? Share your experience:
- Add case studies to `case-studies/`
- Contribute to industry-specific solutions
- Share lessons learned

---

## Style Guidelines

### Markdown

- Use ATX-style headers (`#`, `##`, `###`)
- One sentence per line for easier diffs
- Use fenced code blocks with language identifiers
- Include a blank line before and after code blocks

### Code

**Terraform:**
```hcl
# Use consistent naming
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.workload}-${var.environment}-${var.location}"
  location = var.location
  tags     = local.common_tags
}
```

**Bicep:**
```bicep
// Use descriptive parameter names
@description('Environment name')
@allowed(['prod', 'dev', 'staging'])
param environment string
```

**PowerShell:**
```powershell
# Use approved verbs and PascalCase
function Get-AzureInventory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$SubscriptionId
    )
}
```

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Files | kebab-case | `hub-spoke-network.tf` |
| Directories | kebab-case | `reference-architectures/` |
| Terraform resources | snake_case | `azurerm_virtual_network` |
| Bicep resources | camelCase | `virtualNetwork` |
| Variables | snake_case (TF) / camelCase (Bicep) | `resource_group_name` / `resourceGroupName` |

### Diagrams

- Use ASCII diagrams for inline documentation
- Store graphical diagrams in `diagrams/` directory
- Include source files (`.drawio`) with exports
- Prefer SVG for scalability

---

## Pull Request Process

### 1. Fork and Clone

```bash
git clone https://github.com/YOUR-USERNAME/azure-enterprise-solutions-architecture.git
cd azure-enterprise-solutions-architecture
```

### 2. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/issue-description
```

### 3. Make Changes

- Follow style guidelines
- Add/update tests if applicable
- Update documentation

### 4. Commit

Use clear, descriptive commit messages:

```
Add hub-spoke Terraform module

- Implements hub VNet with Azure Firewall
- Adds configurable spoke VNets
- Includes diagnostic settings
```

### 5. Push and Create PR

```bash
git push origin feature/your-feature-name
```

Then open a Pull Request with:
- Clear title and description
- Reference any related issues
- Screenshots for visual changes

---

## What We're Looking For

### High-Priority Contributions

| Area | What's Needed |
|------|---------------|
| **IaC Modules** | Terraform/Bicep for common patterns |
| **Visual Diagrams** | PNG/SVG architecture diagrams |
| **Industry Solutions** | Retail, Manufacturing, Public Sector |
| **Reference Architectures** | Working examples with IaC |
| **Case Studies** | Real-world implementation stories |

### Code Quality Expectations

- **Terraform:** Pass `terraform fmt` and `terraform validate`
- **Bicep:** Pass `az bicep build`
- **PowerShell:** Follow PSScriptAnalyzer rules
- **Documentation:** No spelling/grammar errors

---

## Questions?

- Open an issue for general questions
- Check existing documentation first
- Review closed issues for common questions

---

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Assume good intentions

---

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

*Thank you for contributing to the Azure architecture community!*
