(in-package :cl-user)

(defpackage :ToyDB
  (:use :common-lisp)
  (:export #:load-db
           #:save-db
           #:insert
           #:delete-all
           #:update
           #:select))