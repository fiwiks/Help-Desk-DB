let create;
let insert;
let del;

async function schemaCall(op) {
	const statusDiv = document.getElementById("admin-status");
	statusDiv.classList.remove("hidden");
	statusDiv.classList.remove("error");
	statusDiv.classList.remove("success");
	statusDiv.textContent = "Running " + op + "...";

	try {
		const res = await fetch("/admin?op=" + encodeURIComponent(op));
		const data = await res.json();

		if (data.ok) {
			statusDiv.textContent = "Success!";
			statusDiv.classList.add("success");
		} else {
			statusDiv.textContent = "Error: " + data.message;
			statusDiv.classList.add("error");
		}
	}
	catch (err) {
		console.log(err);
		statusDiv.textContent = "Request failed, unknown error";
		statusDiv.classList.add("error");
	}
}

document.addEventListener("DOMContentLoaded", function() {
	create = document.getElementById("create");
	insert = document.getElementById("insert");
	del = document.getElementById("delete");

	create.addEventListener("click", () => schemaCall("create"));
	del.addEventListener("click", () => schemaCall("delete"));
	insert.addEventListener("click", () => schemaCall("insert"));
});




