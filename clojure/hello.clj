(defn sayhello [name] (println (str "Hello, " name)))
(println "Whats your name?")
(sayhello (read-line))
