Create VIEW CurrentWeekUpcommingAppointments as
select  *
       from Appointments
       where year(AppointmentDate) = year(getdate()) 
               and datepart(wk, AppointmentDate) = datepart(wk, getdate()) 
               and datepart(d, AppointmentDate) >= datepart(d, getdate())
