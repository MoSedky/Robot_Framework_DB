*** Settings ***
Documentation    Suite description
Library     SeleniumLibrary
Library     DatabaseLibrary

Suite Setup         Connect To Database    pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
*** Variables ***
${DBHost}         127.0.0.1
${DBName}         employees
${DBPass}         Sedky24303252
${DBPort}         3306
${DBUser}         root
${Get_number_of_employees_query}         Select * from employees.employees
${Get_emps_count_per_hiring_date_query}  Select count(emp_no) No_of_employess,gender from employees.employees Where hire_date< DATE_ADD(curdate(),INTERVAL -5 year) group by gender

*** Test Cases ***
Validating Number of Employess

    ${Get_number_of_employees}=              Row Count       ${Get_number_of_employees_query}
    log  ${Get_number_of_employees}

Validating Number of Employess per Gender and Joining Date

    @{Get_emps_count_per_hiring_date} =      Query            ${Get_emps_count_per_hiring_date_query}
    log  ${Get_emps_count_per_hiring_date}
    ${Male_results} =                        Set Variable     ${Get_emps_count_per_hiring_date[0][0]}
    ${Female_results} =                      Set Variable     ${Get_emps_count_per_hiring_date[1][0]}
    log  ${Male_results}
    log  ${Female_results}
    ${Total_Values}=                         Set Variable      Male Employees are ${Male_results} while Female Employess are ${Female_results}
    log  ${Total_Values}

