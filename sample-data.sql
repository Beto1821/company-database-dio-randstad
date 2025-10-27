-- ==============================================
-- 📊 Dados de Exemplo - Company Database
-- 🎯 Projeto: DIO/Randstad Bootcamp
-- 📅 Data: 27/10/2025
-- ==============================================

USE company;

-- ==============================================
-- 🏢 INSERIR DEPARTAMENTOS
-- ==============================================

INSERT INTO departament (Dname, Dnumber, Mgr_start_date, Dept_create_date) VALUES
('Research', 5, '1988-05-22', '1986-01-01'),
('Administration', 4, '1995-01-01', '1990-06-15'),
('Headquarters', 1, '1981-06-19', '1980-01-01'),
('Software', 6, '2000-03-15', '1999-08-01'),
('Hardware', 7, '2005-09-01', '2004-12-01');

-- ==============================================
-- 👥 INSERIR FUNCIONÁRIOS
-- ==============================================

-- Gerentes e Supervisores primeiro (para foreign keys)
INSERT INTO employee (fname, Mname, Lname, Ssn, Bdate, Address, sex, Salary, Super_ssn, Dno) VALUES
('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston, TX', 'M', 55000.00, NULL, 1),
('Franklin', 'T', 'Wong', '333445555', '1965-12-08', '638 Voss, Houston, TX', 'M', 40000.00, '888665555', 5),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire, TX', 'F', 43000.00, '888665555', 4),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble, TX', 'M', 38000.00, '333445555', 5),
('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston, TX', 'F', 25000.00, '333445555', 5),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston, TX', 'M', 25000.00, '987654321', 4),
('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring, TX', 'F', 25000.00, '987654321', 4),
('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston, TX', 'M', 30000.00, '333445555', 5);

-- Atualizar gerentes dos departamentos
UPDATE departament SET Mgr_ssn = '888665555' WHERE Dnumber = 1;
UPDATE departament SET Mgr_ssn = '333445555' WHERE Dnumber = 5;
UPDATE departament SET Mgr_ssn = '987654321' WHERE Dnumber = 4;
UPDATE departament SET Mgr_ssn = '666884444' WHERE Dnumber = 6;
UPDATE departament SET Mgr_ssn = '453453453' WHERE Dnumber = 7;

-- ==============================================
-- 📍 INSERIR LOCALIZAÇÕES DOS DEPARTAMENTOS
-- ==============================================

INSERT INTO dep_locations (Dnumber, Dlocation) VALUES
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Sugarland'),
(5, 'Houston'),
(6, 'Houston'),
(6, 'Sacramento'),
(7, 'Houston');

-- ==============================================
-- 🚀 INSERIR PROJETOS
-- ==============================================

INSERT INTO project (Pname, Pnumber, Plocation, Dnum) VALUES
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4),
('OperatingSystem', 61, 'Sacramento', 6),
('DatabaseSystem', 62, 'Houston', 6),
('MobileApp', 70, 'Houston', 7);

-- ==============================================
-- 💼 INSERIR TRABALHOS EM PROJETOS
-- ==============================================

INSERT INTO works_on (Essn, Pno, Hours) VALUES
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, 16.0),
('666884444', 61, 20.0),
('666884444', 62, 20.0),
('453453453', 70, 15.0);

-- ==============================================
-- 👨‍👩‍👧‍👦 INSERIR DEPENDENTES
-- ==============================================

INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES
('333445555', 'Alice', 'F', '1986-04-04', 'Daughter'),
('333445555', 'Theodore', 'M', '1983-10-25', 'Son'),
('333445555', 'Joy', 'F', '1958-05-03', 'Spouse'),
('987654321', 'Abner', 'M', '1942-02-28', 'Spouse'),
('123456789', 'Michael', 'M', '1988-01-04', 'Son'),
('123456789', 'Alice', 'F', '1988-12-30', 'Daughter'),
('123456789', 'Elizabeth', 'F', '1967-05-05', 'Spouse'),
('888665555', 'Catherine', 'F', '1960-04-05', 'Spouse');

-- ==============================================
-- ✅ VERIFICAÇÕES E RELATÓRIOS
-- ==============================================

-- 📊 Resumo dos dados inseridos
SELECT '📊 RESUMO DOS DADOS INSERIDOS:' AS INFO;

SELECT 
    'EMPLOYEE' as TABELA, 
    COUNT(*) as REGISTROS,
    '👥 Funcionários cadastrados' as DESCRICAO
FROM employee
UNION ALL
SELECT 
    'DEPARTAMENT', 
    COUNT(*), 
    '🏢 Departamentos criados'
FROM departament  
UNION ALL
SELECT 
    'PROJECT', 
    COUNT(*), 
    '🚀 Projetos ativos'
FROM project
UNION ALL
SELECT 
    'WORKS_ON', 
    COUNT(*), 
    '💼 Alocações de trabalho'
FROM works_on
UNION ALL
SELECT 
    'DEPENDENT', 
    COUNT(*), 
    '👨‍👩‍👧‍👦 Dependentes cadastrados'
FROM dependent
UNION ALL
SELECT 
    'DEP_LOCATIONS', 
    COUNT(*), 
    '📍 Localizações dos departamentos'
FROM dep_locations;

-- 🔍 Consultas de exemplo
SELECT '🔍 CONSULTAS DE EXEMPLO:' AS INFO;

-- Funcionários por departamento
SELECT 
    d.Dname as 'Departamento',
    COUNT(e.Ssn) as 'Funcionários'
FROM departament d
LEFT JOIN employee e ON d.Dnumber = e.Dno
GROUP BY d.Dnumber, d.Dname
ORDER BY COUNT(e.Ssn) DESC;

-- Projetos por departamento
SELECT 
    d.Dname as 'Departamento',
    COUNT(p.Pnumber) as 'Projetos'
FROM departament d
LEFT JOIN project p ON d.Dnumber = p.Dnum
GROUP BY d.Dnumber, d.Dname
ORDER BY COUNT(p.Pnumber) DESC;

-- Funcionários com dependentes
SELECT 
    CONCAT(e.fname, ' ', e.Lname) as 'Funcionário',
    COUNT(dep.Dependent_name) as 'Dependentes'
FROM employee e
LEFT JOIN dependent dep ON e.Ssn = dep.Essn
GROUP BY e.Ssn, e.fname, e.Lname
HAVING COUNT(dep.Dependent_name) > 0
ORDER BY COUNT(dep.Dependent_name) DESC;

SELECT '✅ DADOS DE EXEMPLO INSERIDOS COM SUCESSO!' AS STATUS;