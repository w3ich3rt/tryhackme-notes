rule helloworld_text_checker {
	strings:
		$hello_world = "Hello World!"
		$text_file = ".txt"

	condition:
		$hello_world and $text_file
}

rule helloworld_checker {
	strings:
		$hello_world_lowercase = "hello world!"
		$hello_world_uppercase = "HELLO WORLD!"


	condition:
//		$hello_world <= 10 (matches if less or equal then 10 occurrences)
//		or
//		$hello_world and $hello_world_uppercase

		any of them	// All Strings
}
