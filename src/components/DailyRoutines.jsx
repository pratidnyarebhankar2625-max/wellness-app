import { useState, useEffect } from 'react';

export default function DailyRoutines() {
  const [routines, setRoutines] = useState(() => {
    const saved = localStorage.getItem('dailyRoutines');
    return saved ? JSON.parse(saved) : { mWakeup: false, mShot: false, nWater: false, nScreen: false, winddownLock: true };
  });

  const [customGoals, setCustomGoals] = useState(() => {
    const saved = localStorage.getItem('customGoals');
    return saved ? JSON.parse(saved) : [];
  });

  const [newGoalText, setNewGoalText] = useState('');
  const [showBedtimeModal, setShowBedtimeModal] = useState(false);

  useEffect(() => {
    localStorage.setItem('dailyRoutines', JSON.stringify(routines));
  }, [routines]);

  useEffect(() => {
    localStorage.setItem('customGoals', JSON.stringify(customGoals));
  }, [customGoals]);

  const toggle = (key) => setRoutines(prev => ({ ...prev, [key]: !prev[key] }));

  const toggleGoal = (id) => {
    setCustomGoals(prev => prev.map(g => g.id === id ? { ...g, completed: !g.completed } : g));
  };

  const addGoal = (e) => {
    e.preventDefault();
    if (!newGoalText.trim()) return;
    setCustomGoals(prev => [...prev, { id: Date.now(), text: newGoalText.trim(), completed: false }]);
    setNewGoalText('');
  };

  const calculateStats = () => {
    let completedCount = 0;
    let totalCount = 4 + customGoals.length; // 2 morning + 2 evening
    
    if (routines.mWakeup) completedCount++;
    if (routines.mShot) completedCount++;
    if (routines.nWater) completedCount++;
    if (routines.nScreen) completedCount++;
    
    customGoals.forEach(g => {
      if (g.completed) completedCount++;
    });

    return { completedCount, totalCount, percentage: Math.round((completedCount / totalCount) * 100) || 0 };
  };

  return (
    <div className="tab-pane active">
      <div className="header">
        <h1>Daily Routines</h1>
        <p>Welcome back, gorgeous. Let's protect that energy today. ✨</p>
      </div>

      <div className="card">
        <h3 className="card-title">☀️ Morning Intentions</h3>
        <label className="checkbox-item">
          <input type="checkbox" checked={routines.mWakeup} onChange={() => toggle('mWakeup')} />
          <span className="checkbox-box">✓</span>
          <span className="checkbox-text">Early Wake-Up & Exercise Prompt</span>
        </label>
        <label className="checkbox-item">
          <input type="checkbox" checked={routines.mShot} onChange={() => toggle('mShot')} />
          <span className="checkbox-box">✓</span>
          <span className="checkbox-text">Morning Ginger-Honey / Lemon Shot</span>
        </label>
      </div>

      <div className="card">
        <h3 className="card-title">✨ My Intentions & Goals</h3>
        
        <form onSubmit={addGoal} className="goal-input-bar">
          <input 
            type="text" 
            className="goal-input" 
            placeholder="What's your focus today?" 
            value={newGoalText}
            onChange={(e) => setNewGoalText(e.target.value)}
          />
          <button type="submit" className="btn-goal">＋ Add</button>
        </form>

        <div className="custom-goals-list">
          {customGoals.map(goal => (
            <label key={goal.id} className="checkbox-item">
              <input type="checkbox" checked={goal.completed} onChange={() => toggleGoal(goal.id)} />
              <span className="checkbox-box star-box">✧</span>
              <span className="checkbox-text">{goal.text}</span>
            </label>
          ))}
          {customGoals.length === 0 && (
            <p style={{fontSize: '0.85rem', color: 'var(--text-muted)', textAlign: 'center', marginTop: '1rem'}}>
              No custom goals set. Add one above!
            </p>
          )}
        </div>
      </div>

      <div className="card">
        <h3 className="card-title">🌙 Evening Wind-Down</h3>
        <label className="checkbox-item">
          <input type="checkbox" checked={routines.nWater} onChange={() => toggle('nWater')} />
          <span className="checkbox-box">✓</span>
          <span className="checkbox-text">Log Final Water Count</span>
        </label>
        <label className="checkbox-item">
          <input type="checkbox" checked={routines.nScreen} onChange={() => toggle('nScreen')} />
          <span className="checkbox-box">✓</span>
          <span className="checkbox-text">Turn Off Screens & Prepare for Sleep</span>
        </label>
        
        <hr className="card-divider" />
        
        <div className="lock-setting">
          <div className="lock-text">
            <span className="lock-title">Screen Lock Reminder</span>
            <span className="lock-desc">Witty notification alert 30 mins before bed</span>
          </div>
          <label className="switch">
            <input type="checkbox" checked={routines.winddownLock} onChange={() => toggle('winddownLock')} />
            <span className="slider"></span>
          </label>
        </div>
      </div>

      <div style={{textAlign: 'center', marginBottom: '2rem'}}>
        <button className="btn-primary" onClick={() => setShowBedtimeModal(true)} style={{backgroundColor: '#1E2923'}}>
          🌙 Simulate Bedtime Check
        </button>
      </div>

      {showBedtimeModal && (
        <div className="modal-overlay" onClick={() => setShowBedtimeModal(false)}>
          <div className="modal-content" onClick={e => e.stopPropagation()}>
            <h2>Bedtime Audit</h2>
            <p>Here's how you protected your energy today.</p>
            
            <div className="modal-stats">
              <div className="modal-stat">
                <span className="num">{calculateStats().completedCount}/{calculateStats().totalCount}</span>
                <span className="lbl">Tasks Done</span>
              </div>
              <div className="modal-stat">
                <span className="num">{calculateStats().percentage}%</span>
                <span className="lbl">Completion</span>
              </div>
            </div>
            
            <p style={{fontSize: '0.9rem', marginBottom: '1.5rem'}}>
              {calculateStats().percentage === 100 
                ? "Flawless day! You are glowing. Sleep tight! ✨" 
                : "You did your best today, and that's enough. Rest well. 💛"}
            </p>

            <button className="btn-primary" onClick={() => setShowBedtimeModal(false)}>
              Goodnight
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
