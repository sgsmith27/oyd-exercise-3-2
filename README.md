# Exercise 3.2 — Lambda Currency Converter

Curso: Optimizaciones y Desempeño — Cloud Deployment Automation

---

# Objetivo

Construir un módulo reusable de Terraform que despliegue:

- AWS Lambda
- API Gateway HTTP API
- Integración Lambda Proxy
- Rutas HTTP
- Permisos Lambda
- CI pipeline con GitHub Actions

La aplicación implementa un conversor de monedas simple.

---

# Arquitectura

```text
Client
↓
API Gateway HTTP API
↓
Lambda Integration
↓
AWS Lambda
```
---
# Estructura del proyecto
```text
oyd-exercise-3-2/
├── app/
│   ├── index.js
│   └── function.zip
├── infra/
│   ├── provider.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── main.tf
│   ├── envs/
│   │   └── dev/
│   │       └── dev.tfvars
│   ├── modules/
│   │   └── compute_lambda/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   └── evidence/
│       └── function.txt
├── .github/
│   └── workflows/
│       └── terraform-ci.yml
├── .gitignore
└── README.md
```
---

# Variables
| Variable      | Valor     |
| ------------- | --------- |
| region        | us-west-2 |
| environment   | dev       |
| memory_size   | 128       |
| architectures | ["arm64"] |

# Terraform Commands

## Inicialización
```bash
terraform init
```
## Validacion
```bash
terraform validate
```
## Plan
```bash
terraform plan -var-file=envs/dev/dev.tfvars
```
## Apply
```bash
terraform apply -var-file=envs/dev/dev.tfvars
```
## Destroy
```bash
terraform destroy -var-file=envs/dev/dev.tfvars
```
---
# Endpoints
## GET /rates
```bash
curl ${INVOKE_URL}/rates
```
Respuesta:
```bash
{"rates":{"USD":1,"EUR":0.92,"GBP":0.79,"JPY":149.5,"GTQ":7.78}}
```
## POST /convert
```bash
curl -X POST ${INVOKE_URL}/convert \
  -H 'Content-Type: application/json' \
  -d '{"from":"USD","to":"GTQ","amount":100}'
```

Respuesta:
```bash
{"from":"USD","to":"GTQ","amount":100,"result":778}
```
----

# CI Pipeline
El pipeline GitHub Actions ejecuta dos jobs:

## Build
1. Setup Node.js 22
2. Generación del ZIP
3. Upload artifact

## Terraform
1. Download artifact
2. terraform fmt --check -recursive
3. terraform init -backend=false
4. terraform validate
5. terraform plan
6. Publicación automática del plan en el Pull Request
---

# Seguridad aplicada
## Lambda permission
La función Lambda permite invocación únicamente desde:
```bash
apigateway.amazonaws.com
```
mediante:
```bash
aws_lambda_permission
```

# Evidencia
Contenido de:
```bash
infra/evidence/function.txt
```
```text
----------------------------------------------------------------------------------------
|                                      GetFunction                                     |
+-------------+------------------------------------------------------------------------+
|  FunctionArn|  arn:aws:lambda:us-west-2:577133972654:function:oyd-exercise-3-2-dev |
|  State      |  Active                                                               |
+-------------+------------------------------------------------------------------------+
||                                        Arch                                        ||
|+------------------------------------------------------------------------------------+|
||  arm64                                                                             ||
|+------------------------------------------------------------------------------------+|
```
----

# Conceptos aplicados
+ Terraform Modules
+ AWS Lambda
+ API Gateway HTTP API
+ Lambda Proxy Integration
+ GitHub Actions
+ CI pipelines
+ Artifacts
+ source_code_hash
+ Infrastructure as Code
---
# Autor
Sergio Geovany García Smith

Carnet. 25008130