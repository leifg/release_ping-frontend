import './main.css';
import { Main } from './Main.elm';

console.log(process.env)

Main.embed(document.getElementById('root'), {
  url: process.env.ELM_APP_API_URL,
});
