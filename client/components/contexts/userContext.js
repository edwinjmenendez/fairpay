import React, { createContext, useState } from 'react';

export const UserContext = createContext();

const UserContextProvider = props => {
  // User state
  const [user, setUser] = useState({
    name: '',
    jobTitle: '',
    company: '',
    base_salary: '',
  });

  // Stats state
  const [raceList, setRace] = useState([]);
  const [genderList, setGender] = useState([]);
  const [ageList, setAge] = useState([]);
  const [aggregateList, setAggregate] = useState([]);

  // Company wide state
  const [companyList, setCompany] = useState([]);

  const fetchUserData = () => {
    fetch('/api/company')
      .then(res => res.json())
      .then(res => {
        // console.log('in user context', res);
        const {
          currentUser,
          raceStats,
          genderStats,
          ageStats,
          jobStats,
          companyData,
        } = res;

        // Set user state
        const { name, linkedin_id, job_title, base_salary } = currentUser;
        setUser(state => ({
          ...state,
          name: name,
          company: linkedin_id,
          jobTitle: job_title,
          base_salary: base_salary,
        }));

        // Set stats and company wide state
        setRace(raceStats);
        setGender(genderStats);
        setAge(ageStats);
        setAggregate(jobStats);
        setCompany(companyData);
      });
  };

  return (
    <UserContext.Provider
      value={{
        fetchUserData,
        user,
        raceList,
        genderList,
        ageList,
        aggregateList,
        companyList,
      }}
    >
      {props.children}
    </UserContext.Provider>
  );
};

export default UserContextProvider;
