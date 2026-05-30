function scr_screenshake(_tremble = 1)
{

	if (instance_exists(obj_screenshake))
	{
		with(obj_screenshake)
		{
			if (_tremble > tremble)
			{
				tremble = _tremble;	
			}
		}
	}
}