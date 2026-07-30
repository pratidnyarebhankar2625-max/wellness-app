import { useState, useEffect } from 'react';

export default function CycleTracker() {
  const [flow, setFlow] = useState(() => localStorage.getItem('cycleFlow') || '');
  const [symptoms, setSymptoms] = useState(() => JSON.parse(localStorage.getItem('cycleSymptoms') || '[]'));

  useEffect(() => localStorage.setItem('cycleFlow', flow), [flow]);
  useEffect(() => localStorage.setItem('cycleSymptoms', JSON.stringify(symptoms)), [symptoms]);

  const toggleSymptom = (sym) => {
    setSymptoms(prev => prev.includes(sym) ? prev.filter(s => s !== sym) : [...prev, sym]);
  };

  const symptomList = ['Cramps', 'Low Energy', 'Mood Swings', 'Bloating'];

  return (
    <div className="tab-pane active">
      <div className="header">
        <h1>Cycle Tracker</h1>
        <p>Honor your body's natural rhythm. 🌸</p>
      </div>
      
      <div className="card">
        <h3 className="card-title">🌔 Current Phase</h3>
        <div className="phase-circle">
          <span className="day">Day 14</span>
          <span className="name">Ovulatory Phase</span>
        </div>
      </div>

      <div className="card">
        <h3 className="card-title">📝 Log Today</h3>
        
        <h4 style={{marginBottom: '0.5rem', fontSize: '0.9rem', color: 'var(--text-muted)'}}>Flow</h4>
        <div className="tap-grid" style={{marginBottom: '1.5rem'}}>
          {['Light', 'Medium', 'Heavy'].map(level => (
            <div 
              key={level} 
              className={`tap-btn ${flow === level ? 'active' : ''}`}
              onClick={() => setFlow(flow === level ? '' : level)}
            >
              <span className="label" style={{fontSize: '0.85rem'}}>{level}</span>
            </div>
          ))}
        </div>

        <h4 style={{marginBottom: '0.5rem', fontSize: '0.9rem', color: 'var(--text-muted)'}}>Symptoms</h4>
        <div className="tap-grid">
          {symptomList.map(sym => (
            <div 
              key={sym} 
              className={`tap-btn ${symptoms.includes(sym) ? 'active' : ''}`}
              onClick={() => toggleSymptom(sym)}
            >
              <span className="label" style={{fontSize: '0.85rem'}}>{sym}</span>
            </div>
          ))}
        </div>
      </div>

      <div className="card">
        <h3 className="card-title">💡 Phase Insights</h3>
        <div className="insight-box">
          <span className="icon">🌻</span>
          <div>
            <h4>Nutrition Focus</h4>
            <p>You're in your <strong>Ovulatory Phase</strong>! Double down on zinc and magnesium. Incorporate sunflower and pumpkin seeds to support progesterone levels.</p>
          </div>
        </div>
      </div>
    </div>
  );
}
