(in-package :ToyDB-test)

(def-suite all-tests
    :description "The master suite of all toydb tests.")

(in-suite all-tests)

(defun all-t ()
  (run! 'all-tests))



(def-fixture fix-save-db ()
  (progn
    (setf toydb::*db* '((44 "Jerry")(55 "Tom"))) ;直接给数据库赋值
    (&body)
    (setf toydb::*db* nil)))


(test save-db-test ()
  (with-fixture fix-save-db ()
                (progn
                  (save-db #p"Z:/lisp/ToyDB/test/testdb1.txt")
                  (with-open-file (in #p"Z:/lisp/ToyDB/test/testdb1.txt")
                    (with-standard-io-syntax
                      (let ((tmp-file (read in)))
                        (search "Jerry" tmp-file)))))))


(test load-db-test
  (progn
    (load-db (pathname #p"Z:/lisp/ToyDB/test/testdb.txt"))
    (is-true (and
              (=  (caar toydb::*db*) 44)
              (equal (cadar toydb::*db*) "Jerry")))))

                    

(fiveam:def-fixture fix-select ()
  (progn
    (setf toydb::*db* '((44 "Jerry")(55 "Tom"))) ;直接给数据库赋值
    (&body)
    (setf toydb::*db* nil)))


(fiveam:test select-test
  (fiveam:with-fixture fix-select ()
    (let ((tmp-record (select 44)))
      (fiveam:is-true (and
                       (=  (caar tmp-record) 44)
                       (equal (cadar tmp-record) "Jerry"))))))


(fiveam:def-fixture fix-update ()
  (progn
    (setf toydb::*db* '((44 "Jerry")(55 "Tom"))) ;直接给数据库赋值
    (&body)
    (print toydb::*db*)
    (setf toydb::*db* nil)))

(fiveam:test update-test
  (fiveam:with-fixture fix-update ()
    (progn
      (print toydb::*db*)
      (update "student" 55 "CAT")
     (print toydb::*db*)
      (fiveam:is-true (equal  (cadar toydb::*db*) "CAT")))));lisp的append存的内容与其他编程语言里面是相反的，这里append后*db*里面存到是((55 "Tom") (44 "Jerry"))


(fiveam:def-fixture fix-delete ()
  (progn
    (setf toydb::*db*
          '(((ID 44) (STUDENT_NAME "Jerry")) ((ID 44) (STUDENT_NAME "Jerry")))) ;直接给数据库赋值
    (&body)
    (setf toydb::*db* nil)))


(fiveam:test delete-all-test
  (fiveam:with-fixture fix-delete ()
    (fiveam:is-true (delete-all "student"))))


(fiveam:def-fixture fix-insert ()
  (progn
    (setf toydb::*db* nil) ; 相当于SetUp
    (&body) ;   这里的 &body 会被测试用例的 body 替换掉
    (setf toydb::*db* nil))) ; 相当于TearDown


(fiveam:test insert-test
  (fiveam:with-fixture fix-insert ()
    (progn
      (insert "student" '(44 "Jerry"))
      (fiveam:is-true (and
                       (=  (caar toydb::*db*) 44)
                       (equal (cadar toydb::*db*) "Jerry"))))))