import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/**
 * Inicializa a extensão pi-code registrando o hook `before_agent_start`.
 * Este hook garante que o template `PROFILE.md` seja copiado para o diretório
 * `.pi` local do usuário durante a inicialização, caso ele ainda não exista.
 *
 * @param {Object} pi - A instância principal do PI usada para registrar os eventos de ciclo de vida.
 */
export default function main(pi) {
  pi.on("before_agent_start", async (event, context) => {
    if (!context?.cwd) {
      return event;
    }

    const profileDestinationPath = path.join(context.cwd, ".pi", "PROFILE.md");

    if (!fs.existsSync(profileDestinationPath)) {
      const sourceProfilePath = path.join(__dirname, "PROFILE.md");

      if (fs.existsSync(sourceProfilePath)) {
        const templateContent = fs.readFileSync(sourceProfilePath, "utf8");
        fs.mkdirSync(path.dirname(profileDestinationPath), { recursive: true });
        fs.writeFileSync(profileDestinationPath, templateContent, "utf8");
        console.log("✅ pi-code: PROFILE.md base criado com sucesso!");
      }
    }

    return event;
  });
}
