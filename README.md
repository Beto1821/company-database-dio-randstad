# 🏢 Projeto de Análise de Dados - Company Database

Este projeto faz parte do bootcamp de Análise de Dados da **Randstad** em parceria com a **DIO (Digital Innovation One)**. O objetivo é criar e gerenciar um banco de dados relacional para uma empresa, implementando conceitos fundamentais de modelagem de dados e SQL.

## 📋 Descrição do Projeto

O projeto implementa um sistema de banco de dados para gerenciar informações de uma empresa, incluindo:
- Funcionários e seus dados pessoais
- Departamentos e suas localizações
- Projetos da empresa
- Relacionamentos entre funcionários e projetos
- Dependentes dos funcionários

## 🗂️ Estrutura do Banco de Dados

### Tabelas Principais

#### 1. **employee** (Funcionários)
```sql
- fname: Nome (varchar(15))
- Mname: Nome do meio (char)
- Lname: Sobrenome (varchar(25))
- Ssn: Número de segurança social - PK (char(9))
- Bdate: Data de nascimento (DATE)
- Address: Endereço (varchar(30))
- sex: Sexo (char)
- Salary: Salário (decimal(10,2))
- Super_ssn: SSN do supervisor (char(9))
- Dno: Número do departamento (int)
```

#### 2. **departament** (Departamentos)
```sql
- Dname: Nome do departamento (varchar(15))
- Dnumber: Número do departamento - PK (int)
- Mgr_ssn: SSN do gerente (char(9))
- Mgr_start_date: Data de início do gerente (date)
- Dept_create_date: Data de criação do departamento (date)
```

#### 3. **project** (Projetos)
```sql
- Pname: Nome do projeto (varchar(15))
- Pnumber: Número do projeto - PK (int)
- Plocation: Local do projeto (varchar(15))
- Dnum: Número do departamento responsável (int)
```

#### 4. **works_on** (Trabalha em)
Tabela de relacionamento entre funcionários e projetos:
```sql
- Essn: SSN do funcionário (char(9))
- Pno: Número do projeto (int)
- Hours: Horas trabalhadas (decimal(3,1))
```

#### 5. **dependent** (Dependentes)
```sql
- Essn: SSN do funcionário (char(9))
- Dependent_name: Nome do dependente (varchar(15))
- Sex: Sexo (char)
- Bdate: Data de nascimento (date)
- Relationship: Relacionamento (varchar(8))
```

#### 6. **dep_locations** (Localizações dos Departamentos)
```sql
- Dnumber: Número do departamento (int)
- Dlocation: Localização (varchar(15))
```

## 🔧 Funcionalidades Implementadas

### Constraints e Validações
- ✅ **Primary Keys**: Definidas para todas as tabelas
- ✅ **Foreign Keys**: Relacionamentos entre tabelas estabelecidos
- ✅ **Check Constraints**: Validação de salário mínimo (> 2000)
- ✅ **Unique Constraints**: Nome do departamento único
- ✅ **Not Null**: Campos obrigatórios definidos

### Comandos SQL Incluídos
- Criação do schema `company`
- Criação de todas as tabelas com relacionamentos
- Definição de constraints
- Comandos de consulta para visualização dos dados
- Comandos para visualizar estrutura das tabelas

## 🚀 Como Executar

1. **Pré-requisitos:**
   - MySQL Server instalado
   - Cliente MySQL (MySQL Workbench, phpMyAdmin, ou linha de comando)

2. **Executar o script:**
   ```bash
   mysql -u username -p < company.sql
   ```

3. **Verificar criação:**
   ```sql
   USE company;
   SHOW TABLES;
   ```

## 📊 Modelo Entidade-Relacionamento (ER)

O banco de dados segue um modelo relacional clássico com as seguintes relações:

- **Employee** → **Department** (N:1)
- **Employee** → **Employee** (1:N - Supervisor)
- **Department** → **Project** (1:N)
- **Employee** ↔ **Project** (N:M através de works_on)
- **Employee** → **Dependent** (1:N)
- **Department** → **Dep_locations** (1:N)

## 🎯 Objetivos de Aprendizagem

Este projeto demonstra conhecimentos em:
- Modelagem de banco de dados relacional
- Criação de esquemas e tabelas em SQL
- Implementação de constraints e relacionamentos
- Boas práticas em design de banco de dados
- Normalização de dados

## 📚 Conceitos Aplicados

- **Integridade Referencial**: Através de foreign keys
- **Integridade de Domínio**: Constraints de verificação
- **Normalização**: Estrutura organizada sem redundâncias
- **Relacionamentos**: 1:1, 1:N e N:M implementados

## 👨‍💻 Autor

Desenvolvido durante o bootcamp de **Análise de Dados Randstad** na plataforma **DIO**.

## 📄 Licença

Este projeto foi desenvolvido para fins educacionais como parte do bootcamp da DIO/Randstad.

---

*Este README foi criado para documentar o aprendizado e implementação do projeto de banco de dados da empresa.*