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
(defun mytest-insert ()
  (insert "student" '((id 44)(student_name "Jerry"))))

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

(fiveam:test mytest
  
  (fiveam:is (= (+ 1 1) 2)); 应该能通过的
  
  (fiveam:is (= (+ 1 2) 3))) ; 应该失败的