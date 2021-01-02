package exception;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Exception sévère (SQL, Servlet, IO)
 * @author Raphaël Kimm
 *
 */
public class SevereAppException extends AppException {

	private static final long serialVersionUID = 1L;
	
	public SevereAppException(SQLException e, HttpServletRequest request, HttpServletResponse response)  {
		super(ERROR, e, request, response);
		if (e.getErrorCode() != 1644) // Code erreur trigger MySQL
			this.message = "Les données ont été a été altérées. Ajout non autorisé.";
	}

	public SevereAppException(Throwable t, HttpServletRequest request, HttpServletResponse response)  {
		super(ERROR, t, request, response);
	}
	
	public SevereAppException(String s, HttpServletRequest request, HttpServletResponse response)  {
		super(ERROR, s, request, response);
	}
}
