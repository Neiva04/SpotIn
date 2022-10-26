
package spotin;
import java.util.Random;
import java.util.Scanner;

public class Cadastro {
    
    Scanner sc = new Scanner(System.in);

    private String id;
    private String nome;
    private String senha;
    private String email;
    private String dtNascimento;
    private String telefone;
    private boolean pcd;

    public String getId() {
        
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

  
    public String getNome() {
        nome = sc.nextLine();
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSenha() {
        senha = sc.nextLine();
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getEmail() {
        email = sc.nextLine();
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDtNascimento() {
        dtNascimento = sc.nextLine();
        return dtNascimento;
    }

    public void setDtNascimento(String dtNascimento) {
        this.dtNascimento = dtNascimento;
    }

    public String getTelefone() {
        telefone = sc.nextLine();
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public boolean isPcd() {
        
        return pcd;
    }

    public void setPcd(boolean pcd) {
        this.pcd = pcd;
    }
    
    
    
    
    public void CadastroUsuario(){
        setNome(nome);
        setDtNascimento(dtNascimento);
        setSenha(senha);
        setEmail(email);
        setTelefone(telefone);
        
        System.out.println("Bem vind@, faz o cadastro");
        
        System.out.println("nome: ");
        nome = getNome();
        
        System.out.println("data de nascimento: ");
        dtNascimento = getDtNascimento();
        
        System.out.println("senha: ");
        senha = getSenha();
        
        System.out.println("email: ");
        email = getEmail();
        
        System.out.println("telefone: ");
        telefone = getTelefone();
        
    }
  
}
