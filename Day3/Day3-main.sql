-- 1. Inner Join:
-- Question: Retrieve the list of students and their enrolled courses.
SELECT
    student_name,
    course_name
FROM
    students S
    INNER JOIN enrollments E ON E.student_id = S.student_id
    INNER JOIN courses C ON C.course_id = E.course_id;

-- 2. Left Join:
-- Question: List all students and their enrolled courses, including those who haven't enrolled in any course.
SELECT
    student_name,
    course_name
FROM
    students S
    LEFT JOIN enrollments E ON E.student_id = S.student_id
    LEFT JOIN courses C ON C.course_id = E.course_id;

-- 3. Right Join:
-- Question: Display all courses and the students enrolled in each course, including courses with no enrolled students.
SELECT
    student_name,
    course_name
FROM
    students S
    RIGHT JOIN enrollments E ON E.student_id = S.student_id
    RIGHT JOIN courses C ON C.course_id = E.course_id;

-- 4. Self Join:
-- Question: Find pairs of students who are enrolled in at least one common course.
SELECT distinct
    S1.student_name AS student1,
    T2.student_name AS student2
from
    students S1
    INNER JOIN enrollments E1 ON S1.student_id = E1.student_id
    INNER JOIN (
        SELECT
            *
        from
            students S2
            INNER JOIN enrollments E2 ON S2.student_id = E2.student_id
    ) AS T2 ON T2.course_id = E1.course_id
    AND T2.student_name < S1.student_name
order by
    student1
    -- 5. Complex Join:
    -- Question: Retrieve students who are enrolled in 'Introduction to CS' but not in 'Data Structures'.
SELECT
    student_name
FROM
    students S
    INNER JOIN enrollments E ON s.student_id = E.student_id
    INNER JOIN courses C on C.course_id = E.course_id
WHERE
    course_name = 'Introduction to CS'
    AND S.student_id NOT IN (
        SELECT
            student_id
        FROM
            enrollments E
            INNER JOIN courses C ON C.course_id = E.course_id
        WHERE
            course_name = 'Data Structures'
    );

-- Windows function:
-- 1. Using ROW_NUMBER():
-- Question: List all students along with a row number based on their enrollment date in ascending order.
Select
    ROW_NUMBER() OVER (
        ORDER BY
            enrollment_date
    ) as row_number,
    student_name,
    enrollment_date
from
    students S
    INNER JOIN enrollments E ON S.student_id = E.student_id
    -- 2. Using RANK():
    -- Question: Rank students based on the number of courses they are enrolled in, handling ties by assigning the same rank.
SELECT
    RANK() OVER (
        ORDER BY
            COUNT(course_id) DESC
    ) AS rank,
    student_name,
    COUNT(course_id) AS no_of_courses
FROM
    students S
    INNER JOIN enrollments E ON S.student_id = E.student_id
GROUP BY
    S.student_id;

-- 3. Using DENSE_RANK():
-- Question: Determine the dense rank of courses based on their enrollment count across all students
SELECT
    DENSE_RANK() OVER (
        ORDER BY
            COUNT(student_id) DESC
    ) as rank,
    C.course_name,
    COUNT(student_id) as no_of_students
from
    Courses C
    INNER JOIN enrollments E ON C.course_id = E.course_id
GROUP BY
    C.course_id;