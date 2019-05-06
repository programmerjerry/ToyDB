(in-package :ToyDB)

(defparameter *db* nil) ; 定义一个全局变量，数据放到这个全局变量里面

(defun load-db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *db* (read in)))))

(defun save-db (filename)
  (with-open-file (out filename
                       :direction :output
                       :if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out))))


(defun insert (tablename column_names)
  (declare (ignore tablename)) ; 忽略不用的入参,否则编译的时候有警告；不加也能编译通过
  (setf *db* (append (list column_names) *db*))) ; Lisp里面大部分情况，变量都是不可修改的，也就是append 执行的结果是放到一个临时变量里面，实际并没有修改*db*的数据。如果想将最后的值写入变量*db* 需要使用setf函数


(defun delete-all (table-name)
  (declare (ignore table-name))
  (progn
    (setf *db* nil)
    t))

(defun update (table-name id student-name)
  (declare (ignore table-name))
  (let ((tmp-db nil))
    (print *db*)
    (dolist (e *db*)
      (progn
        (print "**************")
        (print *db*)
        (if (= (first e) id)
            (setf tmp-db (append (list (list id student-name)) tmp-db))
          (setf tmp-db (append (list e) tmp-db)))))
    (setf *db* tmp-db)))


(defun select (id)
  (let ((tmp-records nil))
    (dolist (record *db*)
      (if (= (first record) id)
          (setf tmp-records (append (list record) tmp-records))))
    tmp-records))
