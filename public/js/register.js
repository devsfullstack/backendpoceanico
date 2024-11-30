document.getElementById("register-form").addEventListener("submit",async(e)=>{
    e.preventDefault();
    const res = await fetch('http://localhost:4000/register', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                "user":document.getElementById("user").value,
                "password":document.getElementById("password").value,
                "email":document.getElementById("email").value,
                "rol":document.getElementById("rol").value,
                "imagen":document.getElementById("imagen").files[0].name,
                "imagen":document.getElementById("imagen").files[0].size,
                "imagen":document.getElementById("imagen").files[0].type
                })
                })
})