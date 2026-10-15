const API = 'http://127.0.0.1:3600';
const status = document.querySelector('#status');
const output = document.querySelector('#output');
async function health(){
  try { const r=await fetch(API+'/health'); const j=await r.json(); status.textContent='ONLINE — '+j.service; }
  catch(e){ status.textContent='OFFLINE'; output.textContent=String(e); }
}
async function runJob(name){
  const r=await fetch(API+'/api/jobs/run',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({name})});
  output.textContent=JSON.stringify(await r.json(),null,2);
}
document.querySelectorAll('[data-job]').forEach(b=>b.onclick=()=>runJob(b.dataset.job));
health();
