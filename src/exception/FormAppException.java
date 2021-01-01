package exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Exception pour les formulaires
 * @author Raphaël Kimm
 *
 */
public class FormAppException extends AppException {
	
	private static final long serialVersionUID = 1L;

	public FormAppException(Throwable t, HttpServletRequest request, HttpServletResponse response)  {
		super(request.getRequestURL().toString(), t, request, response);
	}
	
	public FormAppException(String s, HttpServletRequest request, HttpServletResponse response)  {
		super(request.getRequestURL().toString(), s, request, response);
	}
}
