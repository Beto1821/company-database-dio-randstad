-- ==============================================
-- 🏢 Projeto: Company Database - DIO/Randstad
-- 👤 Autor: Adalberto R. Ribeiro
-- 📅 Data: 27/10/2025
-- 📝 Descrição: Script otimizado para VS Code
-- ==============================================

-- 🧹 Limpar e criar schema
DROP SCHEMA IF EXISTS company;
CREATE SCHEMA IF NOT EXISTS company;
USE company;

-- ==============================================
-- 📋 CRIAÇÃO DAS TABELAS
-- ==============================================

-- 👥 Tabela: employee (funcionários)
CREATE TABLE company.employee(
    fname VARCHAR(15) NOT NULL COMMENT 'Nome do funcionário',
    Mname CHAR(1) COMMENT 'Inicial do nome do meio',
    Lname VARCHAR(25) NOT NULL COMMENT 'Sobrenome',
    Ssn CHAR(9) NOT NULL COMMENT 'Número segurança social (PK)',
    Bdate DATE COMMENT 'Data de nascimento',
    Address VARCHAR(30) COMMENT 'Endereço residencial',
    sex CHAR(1) COMMENT 'Sexo (M/F)',
    Salary DECIMAL(10,2) COMMENT 'Salário em reais',
    Super_ssn CHAR(9) COMMENT 'SSN do supervisor (FK)',
    Dno INT NOT NULL COMMENT 'Número do departamento (FK)',
    
    -- 🔑 Constraints
    CONSTRAINT pk_employee PRIMARY KEY (Ssn),
    CONSTRAINT chk_salary_employee CHECK (Salary > 2000.00),
    CONSTRAINT chk_sex_employee CHECK (sex IN ('M', 'F'))
) COMMENT = 'Tabela de funcionários da empresa';

-- 🏢 Tabela: departament (departamentos)
CREATE TABLE company.departament(
    Dname VARCHAR(15) NOT NULL COMMENT 'Nome do departamento',
    Dnumber INT NOT NULL COMMENT 'Número do departamento (PK)',
    Mgr_ssn CHAR(9) COMMENT 'SSN do gerente (FK)',
    Mgr_start_date DATE COMMENT 'Data início como gerente',
    Dept_create_date DATE COMMENT 'Data criação departamento',
    
    -- 🔑 Constraints
    CONSTRAINT pk_dept PRIMARY KEY (Dnumber),
    CONSTRAINT unique_name_dept UNIQUE (Dname),
    CONSTRAINT fk_dept_mgr FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
        ON DELETE SET NULL ON UPDATE CASCADE
) COMMENT = 'Tabela de departamentos';

-- 📍 Tabela: dep_locations (localizações dos departamentos)
CREATE TABLE company.dep_locations(
    Dnumber INT NOT NULL COMMENT 'Número do departamento (FK)',
    Dlocation VARCHAR(15) NOT NULL COMMENT 'Localização do departamento',
    
    -- 🔑 Constraints
    PRIMARY KEY (Dnumber, Dlocation),
    CONSTRAINT fk_deploc_dept FOREIGN KEY (Dnumber) REFERENCES departament(Dnumber)
        ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT = 'Localizações dos departamentos';

-- 🚀 Tabela: project (projetos)
CREATE TABLE company.project(
    Pname VARCHAR(15) NOT NULL COMMENT 'Nome do projeto',
    Pnumber INT NOT NULL COMMENT 'Número do projeto (PK)',
    Plocation VARCHAR(15) COMMENT 'Localização do projeto',
    Dnum INT NOT NULL COMMENT 'Departamento responsável (FK)',
    
    -- 🔑 Constraints
    PRIMARY KEY (Pnumber),
    CONSTRAINT unique_name_project UNIQUE (Pname),
    CONSTRAINT fk_project_dept FOREIGN KEY (Dnum) REFERENCES departament(Dnumber)
        ON DELETE RESTRICT ON UPDATE CASCADE
) COMMENT = 'Tabela de projetos da empresa';

-- 💼 Tabela: works_on (funcionário trabalha em projeto)
CREATE TABLE company.works_on(
    Essn CHAR(9) NOT NULL COMMENT 'SSN do funcionário (FK)',
    Pno INT NOT NULL COMMENT 'Número do projeto (FK)',
    Hours DECIMAL(3,1) NOT NULL COMMENT 'Horas trabalhadas por semana',
    
    -- 🔑 Constraints
    PRIMARY KEY (Essn, Pno),
    CONSTRAINT fk_workson_emp FOREIGN KEY (Essn) REFERENCES employee(Ssn)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_workson_proj FOREIGN KEY (Pno) REFERENCES project(Pnumber)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_hours CHECK (Hours >= 0 AND Hours <= 40)
) COMMENT = 'Relacionamento funcionário-projeto';

-- 👨‍👩‍👧‍👦 Tabela: dependent (dependentes)
CREATE TABLE company.dependent(
    Essn CHAR(9) NOT NULL COMMENT 'SSN do funcionário (FK)',
    Dependent_name VARCHAR(15) NOT NULL COMMENT 'Nome do dependente',
    Sex CHAR(1) COMMENT 'Sexo do dependente (M/F)',
    Bdate DATE COMMENT 'Data de nascimento do dependente',
    Relationship VARCHAR(8) COMMENT 'Tipo de relacionamento',
    
    -- 🔑 Constraints
    PRIMARY KEY (Essn, Dependent_name),
    CONSTRAINT fk_dependent_emp FOREIGN KEY (Essn) REFERENCES employee(Ssn)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_sex_dependent CHECK (Sex IN ('M', 'F')),
    CONSTRAINT chk_relationship CHECK (Relationship IN ('Spouse', 'Son', 'Daughter', 'Father', 'Mother'))
) COMMENT = 'Dependentes dos funcionários';

-- ==============================================
-- 🔧 COMANDOS DE VERIFICAÇÃO
-- ==============================================

-- 📋 Listar todas as tabelas
SELECT '📋 TABELAS CRIADAS:' AS INFO;
SHOW TABLES;

-- 🏗️ Verificar estruturas das tabelas
SELECT '🏗️ ESTRUTURA DAS TABELAS:' AS INFO;

SELECT 
    TABLE_NAME as 'Tabela',
    TABLE_COMMENT as 'Descrição'
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'company';

-- 🔗 Verificar constraints e relacionamentos
SELECT '🔗 CONSTRAINTS E RELACIONAMENTOS:' AS INFO;

SELECT 
    CONSTRAINT_NAME as 'Constraint',
    CONSTRAINT_TYPE as 'Tipo',
    TABLE_NAME as 'Tabela'
FROM information_schema.table_constraints 
WHERE constraint_schema = 'company'
ORDER BY TABLE_NAME, CONSTRAINT_TYPE;

-- 📊 Verificar foreign keys
SELECT '📊 FOREIGN KEYS:' AS INFO;

SELECT 
    TABLE_NAME as 'Tabela',
    COLUMN_NAME as 'Coluna',
    REFERENCED_TABLE_NAME as 'Tabela_Referenciada',
    REFERENCED_COLUMN_NAME as 'Coluna_Referenciada'
FROM information_schema.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_SCHEMA = 'company'
ORDER BY TABLE_NAME;

-- 📈 Status inicial das tabelas (vazias)
SELECT '📈 STATUS INICIAL DAS TABELAS:' AS INFO;

SELECT 'EMPLOYEE' as TABELA, COUNT(*) as REGISTROS FROM employee
UNION ALL
SELECT 'DEPARTAMENT', COUNT(*) FROM departament  
UNION ALL
SELECT 'PROJECT', COUNT(*) FROM project
UNION ALL
SELECT 'WORKS_ON', COUNT(*) FROM works_on
UNION ALL
SELECT 'DEPENDENT', COUNT(*) FROM dependent
UNION ALL
SELECT 'DEP_LOCATIONS', COUNT(*) FROM dep_locations;

-- ✅ Script executado com sucesso
SELECT '✅ BANCO DE DADOS COMPANY CRIADO COM SUCESSO!' AS STATUS;

-- ==============================================
-- 📝 PRÓXIMOS PASSOS
-- ==============================================

/*
🎯 PRÓXIMOS PASSOS:

1. 📥 Inserir dados de exemplo:
   source sample-data.sql

2. 🔍 Executar consultas de teste:
   SELECT * FROM employee;
   
3. 📊 Verificar relacionamentos:
   SELECT e.fname, d.Dname 
   FROM employee e 
   JOIN departament d ON e.Dno = d.Dnumber;

4. 🏗️ Criar views para consultas complexas
5. 📋 Implementar stored procedures se necessário
*/