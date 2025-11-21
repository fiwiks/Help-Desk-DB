let form;
let status;

async function submit(e) {
	e.preventDefault();

	console.log("submitting");
	status.classList.remove("hidden", "error", "success");
	status.textContent = "Logging in...";
	
	const username = document.getElementById("username").value;
	const password = document.getElementById("password").value;
	console.log(username);
	console.log(password);

	const body = new URLSearchParams();
	body.append("username",username);
	body.append("password",password);


	try {
		const res = await fetch("/login", {
			method: "POST",
			header: {"Content-Type":"application/x-www-form-urlencoded"},
			body: body.toString()
		})
		const data = await res.json();
		console.log(data);
	
		if (data.ok) {
			status.textContent = "Login Successful, redirecting...";
			status.classList.add("success");
			window.location.href = "/index.html";
		}
		else {
			status.textContent = data.message;
			status.classList.add("error");
		}
	}
	catch (err) {
		console.log(err);
		status.textContent = "Request failed: " + err;
		status.classList.add("error");
	}
}


document.addEventListener("DOMContentLoaded", function() {
	console.log("Adding Events");
	form = document.getElementById("login-form");
	status = document.getElementById("login-status");

	form.addEventListener("submit", (e) => submit(e));
});