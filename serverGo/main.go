package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
	"golang.org/x/crypto/bcrypt"
)

func main() {

	db, err := sql.Open("mysql", "abhay:a123@tcp(127.0.0.1:3306)/PROJECT_V1")
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Connected to the database")

	router := gin.Default()

	router.GET("/", func(ctx *gin.Context) {
		ctx.JSON(http.StatusOK, gin.H{
			"data": "Hello from server",
		})
	})

	router.GET("/ping", func(ctx *gin.Context) {
		ctx.JSON(http.StatusOK, gin.H{
			"error": false,
		})
	})

	router.GET("/course", func(ctx *gin.Context) {
		srn, err := strconv.Atoi(ctx.Query("srn"))
		if err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{
				"error": err.Error(),
			})
			return
		}

		data, err := getCourses(db, srn)

		if err != nil {
			ctx.JSON(http.StatusServiceUnavailable, gin.H{
				"error": err.Error(),
			})
			return
		}
		ctx.JSON(http.StatusOK, gin.H{
			"error": false,
			"data":  data,
		})

	})

	router.POST("/login", func(ctx *gin.Context) {
		email := ctx.PostForm("email")
		pass := ctx.PostForm("pass")
		data, err := verifyLogin(db, email, pass)
		fmt.Println(data, err)
		if err != nil {
			ctx.JSON(http.StatusNotFound, gin.H{
				"error": err.Error(),
			})
		} else {
			ctx.JSON(http.StatusOK, data)
		}
	})

	router.POST("/register", func(ctx *gin.Context) {
		email := ctx.PostForm("email")
		pass := ctx.PostForm("pass")
		data, err := signUp(db, email, pass)
		fmt.Println(data, err)
		if err != nil {
			ctx.JSON(http.StatusNotFound, gin.H{
				"error": err.Error(),
			})
		} else {
			ctx.JSON(http.StatusOK, data)
		}
	})

	router.GET("/notifs", func(ctx *gin.Context) {
		srn, err := strconv.Atoi(ctx.Query("srn"))
		if err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}
		data, err := getNotifs(db, srn)
		if err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		ctx.JSON(http.StatusOK, gin.H{
			"data": data,
		})

	})

	router.GET("/timetable", func(ctx *gin.Context) {
		sem, err := strconv.Atoi(ctx.Query("sem"))
		if err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}
		data, err := getTimeTable(db, sem)
		if err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		ctx.JSON(http.StatusOK, gin.H{
			"data": data,
		})

	})

	router.GET("/results", func(ctx *gin.Context) {
		srn, err := strconv.Atoi(ctx.Query("srn"))
		if err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}
		data, err := getResults(db, srn)
		if err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		ctx.JSON(http.StatusOK, gin.H{
			"data": data,
		})

	})

	router.GET("/profile", func(ctx *gin.Context) {
		srn, err := strconv.Atoi(ctx.Query("srn"))
		if err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		}
		data, err := getProfile(db, srn)
		if err != nil {
			ctx.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		ctx.JSON(http.StatusOK, data)

	})

	router.Run(":6969")

	// Handle the root endpoint ("/") with a custom handler function
	// http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
	// 	fmt.Fprintf(w, "Hello from the server!")
	// })

	// http.Get("/ping") func(w http.ResponseWriter, r *http.Request) {

	// })

	// http.HandleFunc("/data", func(w http.ResponseWriter, r *http.Request) {
	// 	id, name := queryData(db)
	// 	fmt.Fprintf(w, "%d, %s", id, name)
	// })
	// // Start the server on port 8080
	// fmt.Println("Server is running on port 8080")
	// http.ListenAndServe(":8080", nil)
}

func verifyLogin(db *sql.DB, email string, pass string) (map[string]string, error) {

	query := "SELECT EMAIL, PASS FROM LOGINS WHERE EMAIL=?"
	row, err := db.Query(query, email)

	if err != nil || !row.Next() {
		return nil, fmt.Errorf("Email or Password is wrong")
	}

	defer row.Close()

	var hash string
	row.Scan(&email, &hash)
	err = bcrypt.CompareHashAndPassword([]byte(hash), []byte(pass))
	if err != nil {
		fmt.Println("hre", hash)
		return nil, fmt.Errorf("Email or Password is wrong")
	}
	query = "SELECT SRN, BRANCH, SEM FROM STUDENT WHERE EMAIL=?"
	row, err = db.Query(query, email)
	var branch string
	var srn, sem int
	row.Next()
	row.Scan(&srn, &branch, &sem)
	return map[string]string{
		"srn":    strconv.Itoa(srn),
		"branch": branch,
		"sem":    strconv.Itoa(sem),
	}, nil

}

func signUp(db *sql.DB, email string, pass string) (map[string]string, error) {
	hash, err := bcrypt.GenerateFromPassword([]byte(pass), 10)
	if err != nil {
		return nil, err
	}
	query := "SELECT EMAIL FROM LOGINS WHERE EMAIL=?"
	row, err := db.Query(query, email)

	if err != nil || row.Next() {
		return nil, fmt.Errorf("User already registered")
	}

	defer row.Close()

	query = "INSERT INTO LOGINS(EMAIL, PASS) VALUES(?, ?)"
	_, err = db.Exec(query, email, string(hash))
	if err != nil {
		return nil, err
	}
	return map[string]string{"error": "false"}, nil

}

func getNotifs(db *sql.DB, srn int) ([]map[string]string, error) {
	result := make([]map[string]string, 0)

	query := "CALL GetStudentAnnouncements(?)"

	rows, err := db.Query(query, srn)

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	for rows.Next() {
		r := make(map[string]string)
		var link, message, title string
		rows.Scan(&link, &message, &title)
		r["link"] = link
		r["message"] = message
		r["title"] = title
		result = append(result, r)
	}

	return result, nil
}

func getProfile(db *sql.DB, srn int) (map[string]string, error) {

	query := "SELECT SRN, BRANCH, NAME, EMAIL, CGPA, SEM FROM STUDENT WHERE SRN=?"

	row, err := db.Query(query, srn)

	if err != nil {
		return nil, err
	}

	defer row.Close()

	row.Next()
	r := make(map[string]string)
	var branch, name, email string
	var sem int
	var cgpa float64
	row.Scan(&srn, &branch, &name, &email, &cgpa, &sem)
	r["srn"] = strconv.Itoa(srn)
	r["branch"] = branch
	r["name"] = name
	r["email"] = email
	r["cgpa"] = strconv.FormatFloat(cgpa, 'g', 2, 64)
	r["sem"] = strconv.Itoa(sem)

	return r, nil
}

func getTimeTable(db *sql.DB, sem int) ([]map[string]string, error) {

	result := make([]map[string]string, 0)

	query := "CALL GetSemesterSchedule(?)"

	rows, err := db.Query(query, sem)

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	for rows.Next() {
		r := make(map[string]string)
		var day, time, code, name string
		var room_no int
		rows.Scan(&day, &room_no, &time, &code, &name)
		r["day"] = day
		r["room"] = strconv.Itoa(room_no)
		r["time"] = time
		r["code"] = code
		r["name"] = name
		result = append(result, r)
	}

	return result, nil

}

func getResults(db *sql.DB, srn int) ([]map[string]string, error) {
	result := make([]map[string]string, 0)

	query := "CALL CALCULATEGRADES(?)"

	rows, err := db.Query(query, srn)

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	for rows.Next() {
		r := make(map[string]string)
		var code, grade string
		var isa1, isa2, esa int
		var final float64
		rows.Scan(&isa1, &isa2, &esa, &code, &final, &grade)
		r["isa1"] = strconv.Itoa(isa1)
		r["isa2"] = strconv.Itoa(isa2)
		r["esa"] = strconv.Itoa(esa)
		r["code"] = code
		r["grade"] = grade
		r["final"] = strconv.FormatFloat(final, 'g', 4, 64)
		result = append(result, r)
	}

	return result, nil
}

func getCourses(db *sql.DB, srn int) ([]map[string]string, error) {
	result := make([]map[string]string, 0)
	query := `CALL GetStudentCoursesAndElectives(?)`
	rows, err := db.Query(query, srn)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		r := make(map[string]string)
		var code, name, dept string
		var credits int
		rows.Scan(&code, &name, &dept, &credits)
		r["code"] = code
		r["name"] = name
		r["dept"] = dept
		r["credits"] = strconv.Itoa(credits)
		result = append(result, r)
	}

	return result, nil

}

// func createTable(db *sql.DB) {
// 	createTableSQL := `
// 	CREATE TABLE IF NOT EXISTS users (
// 		id INT AUTO_INCREMENT PRIMARY KEY,
// 		username VARCHAR(50) NOT NULL,
// 		email VARCHAR(50) NOT NULL
// 	);`

// 	_, err := db.Exec(createTableSQL)
// 	if err != nil {
// 		log.Fatal(err)
// 	}

// 	fmt.Println("Table created successfully")
// }

// func insertData(db *sql.DB) {
// 	insertDataSQL := "INSERT INTO users (username, email) VALUES (?, ?)"
// 	_, err := db.Exec(insertDataSQL, "john_doe", "john@example.com")
// 	if err != nil {
// 		log.Fatal(err)
// 	}

// 	fmt.Println("Data inserted successfully")
// }

// func queryData(db *sql.DB) (int, string) {
// 	// queryDataSQL := "SELECT id, username, email FROM users"
// 	queryDataSQL := "SELECT * from student"
// 	rows, err := db.Query(queryDataSQL)
// 	if err != nil {
// 		log.Fatal(err)
// 	}
// 	defer rows.Close()

// 	var id int
// 	var name string

// 	for rows.Next() {
// 		// err := rows.Scan(&id, &username, &email)
// 		err := rows.Scan(&id, &name)
// 		if err != nil {
// 			log.Fatal(err)
// 		}
// 		fmt.Printf("ID %d, Name %s\n", id, name)
// 		// fmt.Printf("ID: %d, Username: %s, Email: %s\n", id, username, email)
// 	}

// 	if err := rows.Err(); err != nil {
// 		log.Fatal(err)
// 	}
// 	return id, name
// }
