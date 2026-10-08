import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
const db=createClient(Deno.env.get("SUPABASE_URL")!,Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!);
Deno.serve(async(req)=>{
 try{
  const h=req.headers.get("Authorization");if(!h)throw new Error("Unauthorized");
  const {data:{user}}=await db.auth.getUser(h.replace("Bearer ",""));if(!user)throw new Error("Unauthorized");
  const b=await req.json(),prompt=String(b.prompt??"").trim(),duration=Number(b.duration_seconds??10),quality=b.quality==="pro"?"pro":"standard";
  if(!prompt||duration<5||duration>60)throw new Error("Invalid video request");
  const credits=Math.ceil(duration*(quality==="pro"?12:5));
  const {data:ok,error:ce}=await db.rpc("consume_ai_credits",{p_user_id:user.id,p_credits:credits});if(ce||!ok)throw new Error("Insufficient AI Credits");
  const url=Deno.env.get("VIDEO_PROVIDER_URL"),key=Deno.env.get("VIDEO_PROVIDER_KEY");if(!url||!key)throw new Error("Video provider is not configured");
  const response=await fetch(url,{method:"POST",headers:{"Content-Type":"application/json","Authorization":"Bearer "+key},body:JSON.stringify({prompt,duration_seconds:duration,quality})});
  if(!response.ok)throw new Error("Video provider request failed");
  const data=await response.json();
  const {data:job,error}=await db.from("ai_video_jobs").insert({user_id:user.id,prompt,duration_seconds:duration,quality,credits_charged:credits,status:"processing",provider_job_id:data.id??data.job_id??null,output_url:data.output_url??null}).select("id").single();
  if(error)throw error;
  return new Response(JSON.stringify({job_id:job.id,credits_charged:credits,data}),{headers:{"Content-Type":"application/json"}});
 }catch(e){return new Response(JSON.stringify({error:String(e)}),{status:400,headers:{"Content-Type":"application/json"}});}
});