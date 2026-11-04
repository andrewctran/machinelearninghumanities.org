# Machine Learning & Humanities

GitHub Pages source for https://machinelearninghumanities.org.

Edit `index.md` to update the home page. GitHub Pages builds the site from the root of `main` using Jekyll.

## Domain setup

At the domain's DNS provider, configure these records:

| Type | Name | Value |
| --- | --- | --- |
| A | @ | 185.199.108.153 |
| A | @ | 185.199.109.153 |
| A | @ | 185.199.110.153 |
| A | @ | 185.199.111.153 |
| CNAME | www | andrewctran.github.io |

Replace conflicting parking records for these hosts while preserving unrelated records, including email records.

Once DNS resolves and GitHub issues the certificate, enable **Enforce HTTPS** in the repository's **Settings → Pages**.

GitHub documentation: https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site
