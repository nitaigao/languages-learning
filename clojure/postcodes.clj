; find all the postcodes that containing the given input

(require '[clojure.contrib.str-utils2 :as str])

(defn filter_postcode [item]
  (let [clean (str/replace item " " "")]
    (str/contains? clean "KT220HD")))

(defn map_postcode [line] (first (str/split line #",")))

(defn find_postcode [rows]
  (let [postcodes (map map_postcode rows)]
    (filter filter_postcode postcodes)))  

(with-open [rdr (java.io.BufferedReader.(java.io.FileReader. "uk-post-codes-2009"))]
  (let [lines (line-seq rdr)]
    (let [rows (rest lines)]
      (let [matches (find_postcode rows)]
        (println(count matches))))))