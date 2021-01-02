package exception;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Exception pour les formulaires
 * @author Raphaël Kimm
 *
 */
public class FormAppException extends AppException {
	
	private static final long serialVersionUID = 1L;

	public FormAppException(SQLException e, HttpServletRequest request, HttpServletResponse response)  {
		super(request.getRequestURL().toString(), e, request, response);
		if (e.getErrorCode() != 1644) // Code erreur trigger MySQL
			this.message = "Une erreur sévère s'est produite lors de l'accès à la base de données.";
	}
	
	public FormAppException(Throwable t, HttpServletRequest request, HttpServletResponse response)  {
		super(request.getRequestURL().toString(), t, request, response);
	}
	
	public FormAppException(String s, HttpServletRequest request, HttpServletResponse response)  {
		super(request.getRequestURL().toString(), s, request, response);
	}
}
