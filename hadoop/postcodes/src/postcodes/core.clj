(ns postcodes.core
  (require 
    [clojure-hadoop.defjob :as defjob]
    [clojure-hadoop.imports :as imp]
    [clojure-hadoop.wrap :as wrap]
    [clojure.contrib.str-utils2 :as str]))

(imp/import-io)
(imp/import-mapred)

(def search_string "3E")

(defn postcode [line] (first (str/split line #",")))

(defn int-string-writer [#^OutputCollector output key #^String value]
  (.collect output key (Text. value)))

(defn string-int-writer [#^OutputCollector output #^String key value]
  (.collect output (Text. key) value))

  
(defn string-string-reduce-reader [key wvalues] 
  [
    (map (fn [v] [key v]) (iterator-seq wvalues))
  ])
  
(defn map_postcode [offset line]
  (if (str/contains? line search_string)
    [[(Text. "1") (postcode line)]]
    []))

(defn reduce_sum [values]
  [[search_string (count values)]])

(defjob/defjob job
  :map map_postcode
  :map-reader wrap/int-string-map-reader
  :map-writer int-string-writer
  :reduce reduce_sum
  :reduce-reader string-string-reduce-reader
  :reduce-writer string-int-writer
  :output-key Text
  :output-value Text
  :output-format :text
  :input-format :text
  :compress-output false)
  
; java -cp postcodes-standalone.jar clojure_hadoop.job -job postcodes.core.process/job -input uk-postcodes -output output