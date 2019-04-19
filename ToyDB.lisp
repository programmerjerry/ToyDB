#|	SQL:
	INSERT INTO student(id, student_name) VALUES(44, 'Jerry');
	
	调用的函数：
	insert(tablename column_names)

	拼上了实际值的函数：
	insert("student"	'((id 44)(student_name "Jerry"))|#



(defparameter *db* nil) ; 定义一个全局变量，数据放到这个全局变量里面

;(defun make-record (id student_name)
;  (list :id id :student_name student_name))

(defun insert (tablename column_names)
  (declare (ignore tablename)) ; 忽略不用的入参,否则编译的时候有警告；不加也能编译通过
  (setf *db* (append (list column_names) *db*))) ; Lisp里面大部分情况，变量都是不可修改的，也就是append 执行的结果是放到一个临时变量里面，实际并没有修改*db*的数据。如果想将最后的值写入变量*db* 需要使用setf函数


;; 自己随便写的测试用例，后面找个测试框架来用
;(defun mytest-insert ()
;  (insert "student" '((id 44)(student_name "Jerry"))))

#|
(defun delete (tablename id)
  ())

(defun mytest-delete ()
  ())

(defun update ()
  ())

(defun mytest-update ()
  ())

(defun select ()
  ())

(defun mytest-select ()
  ())|#

(defun delete-all (table-name)
  (declare (ignore table-name))
  (progn
    (setf *db* nil)
    t))

(defun update (table-name id student-name)
  (declare (ignore table-name))
  (let ((tmp-db nil))
    (dolist (e *db*)
      (progn
        (if (= (first e) id)
            (setf tmp-db (append (list (list id student-name)) tmp-db))
          (setf tmp-db (append (list e) tmp-db)))))
    (setf *db* tmp-db)))



(fiveam:def-fixture fix-update ()
  (progn
    (setf *db* '((44 "Jerry")(55 "Tom"))) ;直接给数据库赋值
    (&body)
    (setf *db* nil)))

(fiveam:test update-test
  (fiveam:with-fixture fix-update ()
    (progn
      (update "student" 55 "CAT")
      (fiveam:is-true (equal  (cadar *db*) "CAT")))));lisp的append存的内容与其他编程语言里面是相反的，这里append后*db*里面存到是((55 "Tom") (44 "Jerry"))

    



















(fiveam:def-fixture fix-delete ()
  (progn
    (setf *db*
          '(((ID 44) (STUDENT_NAME "Jerry")) ((ID 44) (STUDENT_NAME "Jerry")))) ;直接给数据库赋值
    (&body)
    (setf *db* nil)))


(fiveam:test delete-all-test
  (fiveam:with-fixture fix-delete ()
    (fiveam:is-true (delete-all "student"))))
    


























(fiveam:def-fixture fix-1 ()
  (progn
    (setf *db* nil) ; 相当于SetUp
   ; (print "aa")
    (&body) ;   这里的 &body 会被测试用例的 body 替换掉
    (setf *db* nil))) ; 相当于TearDown
    ;(print "bb")))

(fiveam:test fixtest
  (fiveam:with-fixture fix-1 ()
     ; (fiveam:is (= (+ 2 2) 4))
      (fiveam:is-true (insert "student" '((id 44)(student_name "Jerry"))))))


;(fiveam:test mytest-insert
 ; (fiveam:is-true (insert "student" '((id 44)(student_name "Jerry")))))

(fiveam:test mytest
  
  (fiveam:is (= (+ 1 1) 2)); 应该能通过的
  
  (fiveam:is (= (+ 1 2) 3))) ; 应该失败的