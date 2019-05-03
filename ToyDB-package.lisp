(in-package :cl-user)

(defpackage :ToyDB
  (:use :common-lisp)
  (:export #:insert
           #:delete-all
           #:update
           #:select))