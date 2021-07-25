## 这是一个验证Gitlab CICD Demo环境
### 介绍
基于客户实际工作场景中CICD的需求，同时结合IaC(基础设施即代码),GitOps的理念,使用Gitlab(Gitlab CI and Gitlab runner), Terraform, AWS EKS(托管的kubernetes), AWS RDS, AWS ECR, Liquibase来构建一个完整的CICD的Pipeline.  其中包括  

1)通过Gitlab CICD和Terraform自动化的创建和部署AWS EKS Cluster和RDS for Mysql. 偏基础设施的团队会更关注这一点.  
2)再通过Gitlab CICD结合AWS EKS和Liquibase来达成应用系统的版本迭代和发布. 偏业务的团队会更关注这一块.

### 目录
```
.  
 \  
  -- README.md         就是此文件  
  -- create_bucket.sh  在s3上创建 Terraform 状态文件  
  -- .gitlab-ci.yml    Gitlab CI 的配置文件  
  -- infra  
         \_eks-cluster  创建 AWS EKS Cluster 的 Terraform 文件目录  
         \_rdsmysq      创建 AWS RDS for Mysql 的 Terraform 文件目录  
  -- app        
         \_eks          自动在infra脚本创建的EKS Cluster中部署application  
         \_rds          自动根据dbchangelog.xml文件定义的内容更新或是回滚RDS数据库  
```  

### 完整的文件树信息
![avatar](https://raw.githubusercontent.com/jerryjin2018/gitlabcicd/main/files_structs_1.png)
![avatar](https://raw.githubusercontent.com/jerryjin2018/gitlabcicd/main/files_structs_2.png)
