(defproject postcodes "1.0.0-SNAPSHOT"
  :description "FIXME: write"
  :dev-dependencies [
      [lein-javac "0.0.1-SNAPSHOT"]]
  :namespaces [
      postcodes.core
    ]
  :javac-target "1.6"
  :javac-debug "true"
  :dependencies [
    [commons-cli/commons-cli "1.2"]
    [org.clojure/clojure "1.1.0"]
    [org.clojure/clojure-contrib "1.1.0"]
    [com.stuartsierra/clojure-hadoop "1.2.0-SNAPSHOT"]])
