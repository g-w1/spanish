(defconstant tenses '(("present indicative" "Used for regular in present tense."
                                (((ar) "o" "as" "a" "amos" "an") ((er) "o" "es" "e" "emos" "en") ((ir) "o" "es" "e" "imos" "en")))
                      ("preterite" "Past tense, actions completed in past." 
                                   (((ar) "é" "aste" "ó" "amos" "aron") ((er ir) "í" "iste" "ió" "imos" "ieron")))
                      ("imperfect" "Past tense, actions not completed in past." 
                                   (((ar) "aba" "abas" "aba" "ábamos" "aban") ((er ir) "ía" "ías" "ía" "íamos" "ían")))))

(defun html-file (base)
    (format nil "~(~A~).html" base))

(defconstant style "<style>table, td, tr { border: 1px solid black; }</style>")

(defun single-conj-table (table)
    (let* ((verb-type (car table))
           (endings (cdr table))
           (reorderd-endings (list (nth 0 endings) (nth 3 endings) (nth 1 endings) (nth 2 endings) (nth 4 endings))))
        (progn 
         (format t "<p>Verb Type: ~A</p>" verb-type)
         (apply #'format t "<table><tr><td>~A</td><td>~A</td></tr><tr><td>~A</td><td></td></tr><tr><td>~A</td><td>~A</td></tr></table>" reorderd-endings))))
               

(defun render-tense (tense)
    (let ((tensename (car tense))
          (tensedesc (cadr tense))
          (conjugations (caddr tense)))
     (progn
      (format t "<h2>~a</h2>~%<p>~a</p>~%" (string-capitalize tensename) tensedesc)
      (mapcar #'single-conj-table conjugations))))

(defun render-content () (progn
                          (mapcar #'render-tense tenses)))

                                        
    

(defun render-spanish ()
    (with-open-file (*standard-output*
                     (html-file 'database)
                     :direction :output
                     :if-exists :supersede)
        (progn
         (format t "<head><title>Spanish Database</title>~a</head><body>~%" style)
         (render-content)
         (format t "</body>~%"))))

(render-spanish)
