--EX - Query con GROUP BY
--1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(enrolment_date) as Iscrizioni,YEAR(enrolment_date) AS Anno FROM students
GROUP BY YEAR(enrolment_date)
ORDER BY YEAR(enrolment_date)ASC

--2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(office_address) AS indirizzi, office_address FROM teachers
GROUP BY(office_address)
SELECT * FROM degrees

--3. Calcolare la media dei voti di ogni appello d'esame

SELECT AVG(vote) as media,exam_id FROM exam_student
GROUP BY(exam_id)

--4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT COUNT(department_id) AS n_dipartimento_corsi FROM degrees
GROUP BY(department_id)

--EX - Query con JOIN
--1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT * FROM students
JOIN degrees
ON degrees.id=students.degree_id
WHERE degrees.name='Corso di Laurea in Economia'

--2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze

SELECT degrees.name FROM degrees
JOIN departments
ON departments.id=degrees.department_id
WHERE departments.name='Dipartimento di Neuroscienze' AND degrees.level='magistrale'

--3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT * FROM courses
JOIN course_teacher
ON course_teacher.course_id=courses.id
JOIN teachers
ON teachers.id=course_teacher.teacher_id
WHERE teachers.name='fulvio' AND teachers.surname='amato'

--4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
--relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT students.surname,students.name,degrees.name,departments.name FROM students
JOIN degrees
ON degrees.id=students.degree_id
JOIN departments
ON departments.id=degrees.department_id

ORDER BY students.surname,students.name

--5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT teachers.surname,teachers.name,courses.name FROM course_teacher

JOIN teachers
ON course_teacher.teacher_id=teachers.id
JOIN courses
ON course_teacher.course_id=courses.id
ORDER BY teachers.surname,teachers.name

--6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT distinct teachers.name,teachers.surname FROM teachers
JOIN course_teacher
ON course_teacher.teacher_id=teachers.id
JOIN courses
ON courses.id=course_teacher.course_id
JOIN degrees
ON courses.degree_id=degrees.id
JOIN departments
ON departments.id=degrees.department_id
WHERE departments.name = 'Dipartimento di Matematica'

--7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per
--superare ciascuno dei suoi esami

--Query se vogliamo recupare i tentativi per ogni singolo esame
SELECT exams.id,students.id,students.name,students.surname,COUNT(exams.id) AS 'tentaivi d''esame' FROM students
JOIN exam_student
ON exam_student.student_id=students.id
JOIN exams
ON exams.id=exam_student.exam_id
GROUP BY students.id,students.name,students.surname,exams.id
ORDER BY students.name
--Query se vogliamo recupare i tentativi totali per tutti gli esami
SELECT students.id,students.name,students.surname,COUNT(students.id) AS 'tentaivi d''esame' FROM students
JOIN exam_student
ON exam_student.student_id=students.id
JOIN exams
ON exams.id=exam_student.exam_id
GROUP BY students.id,students.name,students.surname
ORDER BY students.name