//! # Módulo de Versionado de Aezka OS
//!
//! Este módulo proporciona información sobre la versión de Aezka OS,
//! incluyendo número de versión, codename y fecha de compilación.
//!
//! ## Formato de Versión
//!
//! - **Largo**: `Aezka (Codename | Mayor.Menor.Patch | FechaCompilación)`
//! - **Corto**: `Aezka (Codename)`
//!
//! ## Ejemplo de Uso
//!
//! ```rust
//! use aezka::version::AezkaVersion;
//!
//! let version = AezkaVersion::new();
//! println!("{}", version.long_format());
//! println!("{}", version.short_format());
//! ```
//!
//! ## Implementador
//! Mister_F - 2025
//!
//! ## Copyright
//! Copyright (c) 2025 Aezka & Mister_F
//! Basado en Redox OS - Copyright (c) 2016 Redox OS Developers

use std::fmt;

/// Versión Major de Aezka
pub const VERSION_MAJOR: u32 = 0;

/// Versión Minor de Aezka
pub const VERSION_MINOR: u32 = 1;

/// Versión Patch de Aezka
pub const VERSION_PATCH: u32 = 0;

/// Codename de la versión actual
pub const CODENAME: &str = "Taquion";

/// Nombre del sistema
pub const OS_NAME: &str = "Aezka";

/// Información del kernel base
pub const KERNEL_BASE: &str = "Redox OS";

/// Estructura que representa la información de versión de Aezka
///
/// # Implementador
/// Mister_F - 2025
#[derive(Debug, Clone)]
pub struct AezkaVersion {
    /// Versión major
    pub major: u32,
    /// Versión minor
    pub minor: u32,
    /// Versión patch
    pub patch: u32,
    /// Codename de la versión
    pub codename: String,
    /// Fecha de compilación (YYYYMMDD)
    pub build_date: String,
}

impl AezkaVersion {
    /// Crea una nueva instancia de AezkaVersion
    ///
    /// La fecha de compilación se genera automáticamente en tiempo de compilación.
    ///
    /// # Retorna
    /// Nueva instancia de AezkaVersion
    ///
    /// # Implementador
    /// Mister_F - 2025
    pub fn new() -> Self {
        Self {
            major: VERSION_MAJOR,
            minor: VERSION_MINOR,
            patch: VERSION_PATCH,
            codename: CODENAME.to_string(),
            build_date: Self::get_build_date(),
        }
    }

    /// Obtiene la fecha de compilación en formato YYYYMMDD
    ///
    /// # Retorna
    /// String con la fecha en formato YYYYMMDD
    ///
    /// # Implementador
    /// Mister_F - 2025
    fn get_build_date() -> String {
        // En tiempo de compilación real, esto se obtendría de variables de entorno
        // o del sistema de build. Por ahora usamos una fecha de ejemplo.
        env!("BUILD_DATE", "Esta variable se debe configurar en tiempo de build")
            .to_string()
    }

    /// Retorna la versión en formato largo
    ///
    /// # Formato
    /// `Aezka (Codename | Mayor.Menor.Patch | FechaCompilación)`
    ///
    /// # Ejemplo
    /// ```
    /// Aezka (Taquion | 0.1.0 | 20250103)
    /// ```
    ///
    /// # Implementador
    /// Mister_F - 2025
    pub fn long_format(&self) -> String {
        format!(
            "{} ({} | {}.{}.{} | {})",
            OS_NAME,
            self.codename,
            self.major,
            self.minor,
            self.patch,
            self.build_date
        )
    }

    /// Retorna la versión en formato corto
    ///
    /// # Formato
    /// `Aezka (Codename)`
    ///
    /// # Ejemplo
    /// ```
    /// Aezka (Taquion)
    /// ```
    ///
    /// # Implementador
    /// Mister_F - 2025
    pub fn short_format(&self) -> String {
        format!("{} ({})", OS_NAME, self.codename)
    }

    /// Retorna solo el número de versión
    ///
    /// # Formato
    /// `Mayor.Menor.Patch`
    ///
    /// # Ejemplo
    /// ```
    /// 0.1.0
    /// ```
    ///
    /// # Implementador
    /// Mister_F - 2025
    pub fn version_number(&self) -> String {
        format!("{}.{}.{}", self.major, self.minor, self.patch)
    }

    /// Retorna información del kernel
    ///
    /// # Formato
    /// `Aezka Kernel (Basado en Kernel_Base)`
    ///
    /// # Implementador
    /// Mister_F - 2025
    pub fn kernel_info(&self) -> String {
        format!("{} Kernel (Basado en {})", OS_NAME, KERNEL_BASE)
    }
}

impl Default for AezkaVersion {
    fn default() -> Self {
        Self::new()
    }
}

impl fmt::Display for AezkaVersion {
    /// Implementación de Display que muestra el formato largo
    ///
    /// # Implementador
    /// Mister_F - 2025
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.long_format())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_version_creation() {
        let version = AezkaVersion::new();
        assert_eq!(version.major, VERSION_MAJOR);
        assert_eq!(version.minor, VERSION_MINOR);
        assert_eq!(version.patch, VERSION_PATCH);
        assert_eq!(version.codename, CODENAME);
    }

    #[test]
    fn test_version_number() {
        let version = AezkaVersion::new();
        assert_eq!(
            version.version_number(),
            format!("{}.{}.{}", VERSION_MAJOR, VERSION_MINOR, VERSION_PATCH)
        );
    }

    #[test]
    fn test_short_format() {
        let version = AezkaVersion::new();
        assert!(version.short_format().contains(CODENAME));
        assert!(version.short_format().contains(OS_NAME));
    }
}
