document.getElementById("register-form").addEventListener("submit",async(e)=>{
    e.preventDefault();
    const res = await fetch('http://localhost:4000/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                "user":document.getElementById("user").value,
                "password":document.getElementById("password").value,
                })
            })
            if( res.ok ){
                const data = await res.json();
                console.log(data);
                window.location.href = "http://localhost:4000/admin"
                }
        })