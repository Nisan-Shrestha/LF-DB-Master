-- Find all students enrolled in the Math course.
SELECT
    student_name
FROM
    Students
WHERE
    student_id IN (
        SELECT
            student_id
        FROM
            Enrollments
        WHERE
            course_id = (
                SELECT
                    course_id
                FROM
                    Courses
                WHERE
                    course_name = 'Math'
            )
    );

-- List all courses taken by students named Bob.
SELECT
    course_name
FROM
    courses
WHERE
    course_id IN (
        SELECT
            course_id
        FROM
            enrollments
        WHERE
            student_id = (
                SELECT
                    student_id
                FROM
                    students
                WHERE
                    student_name = 'Bob'
            )
    );

-- Find the names of students who are enrolled in more than one course.
SELECT
    student_name
FROM
    students
WHERE
    student_id IN (
        SELECT
            student_id
        FROM
            enrollments
        GROUP BY
            student_id
        HAVING
            COUNT(course_id) > 1
    );

-- List all students who are in Grade A (grade_id = 1).
SELECT
    student_name
FROM
    students
WHERE
    student_grade_id = 1;

-- Find the number of students enrolled in each course.
SELECT
    course_name,
    (
        SELECT
            COUNT(*)
        FROM
            Enrollments E
        WHERE
            E.course_id = C.course_id
    ) AS number_of_students
FROM
    Courses C;

-- Retrieve the course with the highest number of enrollments.
SELECT
    course_name,
    (
        SELECT
            COUNT(*)
        FROM
            Enrollments E
        WHERE
            E.course_id = C.course_id
    ) AS number_of_students
FROM
    Courses C
ORDER BY
    number_of_students desc
LIMIT
    1;

-- List students who are enrolled in all available courses.
SELECT
    student_name
FROM
    Students
WHERE
    student_id IN (
        SELECT
            student_id
        FROM
            Enrollments
        GROUP BY
            student_id
        HAVING
            COUNT(course_id) = (
                SELECT
                    COUNT(course_id)
                FROM
                    Courses
            )
    );

-- Find students who are not enrolled in any courses.
SELECT
    student_name
FROM
    Students
WHERE
    student_id NOT IN (
        SELECT
            student_id
        FROM
            Enrollments
        GROUP BY
            student_id
        HAVING
            COUNT(course_id) > 0
    );

-- Retrieve the average age of students enrolled in the Science course.
SELECT
    AVG(student_age) as Avg_Age
FROM
    Students
WHERE
    student_id IN (
        SELECT
            student_id
        FROM
            Enrollments
        WHERE
            course_id = (
                SELECT
                    course_id
                FROM
                    courses
                WHERE
                    course_name = 'Science'
            )
    );

-- Find the grade of students enrolled in the History course.
SELECT
    student_name,
    (
        Select
            grade_name
        from
            grades G
        where
            S.student_grade_id = G.grade_id
    ) as Grade
from
    Students S
where
    student_id in (
        select
            student_id
        from
            Enrollments E
        where
            E.course_id = (
                Select
                    course_id
                from
                    courses
                where
                    course_name = 'History'
            )
    )