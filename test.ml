let _ =
   let file = Sys.argv.(1) in
   let cfg = Ini_config.parse file in
      List.iter (fun (s, kvl) ->
		    Printf.printf "[%s]\n" s;
		    List.iter (fun (k,v) ->
				  Printf.printf "[%s] = [%s]\n" k v
			      ) kvl
		) cfg;

      let list = Ini_config.get_value_list cfg "global" "my_recipients" in
	 List.iter (fun l -> print_endline l) list
