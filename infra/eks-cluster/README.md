## 这是一个验证Gitlab CICD Demo环境
### 介绍
基于客户实际工作场景中CICD的需求，同时结合IaC(基础设施即代码),GitOps的理念,使用Gitlab(Gitlab CI and Gitlab runner), Terraform, AWS EKS(托管的kubernetes), AWS RDS, AWS ECR, Liquibase来构建一个完整的CICD的Pipeline.  其中包括  

1)通过Gitlab CICD和Terraform自动化的创建和部署AWS EKS Cluster和RDS for Mysql. 偏基础设施的团队会更关注这一点.  
2)再通过Gitlab CICD结合AWS EKS和Liquibase来达成应用系统的版本迭代和发布. 偏业务的团队会更关注这一块.  
