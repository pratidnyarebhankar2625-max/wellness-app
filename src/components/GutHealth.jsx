import { useState, useEffect } from 'react';

export default function GutHealth() {
  const [consistency, setConsistency] = useState(() => localStorage.getItem('gutConsistency') || '');
  const [ease, setEase] = useState(() => localStorage.getItem('gutEase') || '');
  const [feels, setFeels] = useState(() => JSON.parse(localStorage.getItem('gutFeels') || '[]'));

  useEffect(() => localStorage.setItem('gutConsistency', consistency), [consistency]);
  useEffect(() => localStorage.setItem('gutEase', ease), [ease]);
  useEffect(() => localStorage.setItem('gutFeels', JSON.stringify(feels)), [feels]);

  const toggleFeel = (f) => setFeels(prev => prev.includes(f) ? prev.filter(s => s !== f) : [...prev, f]);

  const bristolScale = [
    { id: 'hard', emoji: '🪨', label: 'Hard/Lumpy' },
    { id: 'sausage', emoji: '🌭', label: 'Sausage' },
    { id: 'smooth', emoji: '🐍', label: 'Smooth/Soft' },
    { id: 'liquid', emoji: '💧', label: 'Liquid/Mushy' }
  ];

  return (
    <div className="tab-pane active">
      <div className="header">
        <h1>Gut Health</h1>
        <p>Listen to your second brain. 🦠</p>
      </div>
      
      <div className="card">
        <h3 className="card-title">💩 Daily Consistency</h3>
        <p style={{fontSize: '0.85rem', color: 'var(--text-muted)', marginBottom: '1rem'}}>
          Tap the icon that best matches today's movement.
        </p>
        
        <div className="tap-grid">
          {bristolScale.map(item => (
            <div 
              key={item.id} 
              className={`tap-btn ${consistency === item.id ? 'active' : ''}`}
              onClick={() => setConsistency(consistency === item.id ? '' : item.id)}
            >
              <span className="emoji">{item.emoji}</span>
              <span className="label">{item.label}</span>
            </div>
          ))}
        </div>
      </div>

      <div className="card">
        <h3 className="card-title">📝 Digestive Notes</h3>
        
        <h4 style={{marginBottom: '0.5rem', fontSize: '0.9rem', color: 'var(--text-muted)'}}>Digestion Ease</h4>
        <div className="tap-grid" style={{marginBottom: '1.5rem'}}>
          {['Effortless', 'Normal', 'Straining'].map(level => (
            <div 
              key={level} 
              className={`tap-btn ${ease === level ? 'active' : ''}`}
              onClick={() => setEase(ease === level ? '' : level)}
            >
              <span className="label" style={{fontSize: '0.85rem'}}>{level}</span>
            </div>
          ))}
        </div>

        <h4 style={{marginBottom: '0.5rem', fontSize: '0.9rem', color: 'var(--text-muted)'}}>How do you feel?</h4>
        <div className="tap-grid">
          {['Bloated', 'Light & Empty', 'Gassy', 'Good after Ginger Shot'].map(sym => (
            <div 
              key={sym} 
              className={`tap-btn ${feels.includes(sym) ? 'active' : ''}`}
              onClick={() => toggleFeel(sym)}
            >
              <span className="label" style={{fontSize: '0.85rem'}}>{sym}</span>
            </div>
          ))}
        </div>
      </div>

      <div className="card">
        <h3 className="card-title">🔥 Regularity Streak</h3>
        <div className="insight-box">
          <span className="icon">📅</span>
          <div>
            <h4 style={{color: 'var(--accent-primary)', fontSize: '1.1rem'}}>5 Days Strong!</h4>
            <p>Consistent morning routine. Your gut is loving those seed shots and early hydration.</p>
          </div>
        </div>
      </div>
    </div>
  );
}
