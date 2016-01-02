{-# LANGUAGE CPP #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE EmptyDataDecls #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE UndecidableInstances #-}

#ifdef DataPolyKinds
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE DataKinds #-}
#endif

#ifdef SafeHaskell
{-# LANGUAGE Safe #-}
#endif

#include "kinds.h"

module Type.Ordering
    ( LT
    , EQ
    , GT
    )
where

#ifndef DataPolyKinds
-- base ----------------------------------------------------------------------
import           Data.Typeable (Typeable)


#endif
-- types ---------------------------------------------------------------------
#ifndef DataPolyKinds
import           Type.Meta (Known, val)
#endif
import           Type.Semigroup ((:<>))


#ifdef DataPolyKinds
------------------------------------------------------------------------------
type LT = 'LT


------------------------------------------------------------------------------
type EQ = 'EQ


------------------------------------------------------------------------------
type GT = 'GT
#else
------------------------------------------------------------------------------
data LT
  deriving (Typeable)


------------------------------------------------------------------------------
data EQ
  deriving (Typeable)


------------------------------------------------------------------------------
data GT
  deriving (Typeable)


------------------------------------------------------------------------------
instance Known Ordering LT where
    val _ = LT
    {-# INLINE val #-}


------------------------------------------------------------------------------
instance Known Ordering EQ where
    val _ = EQ
    {-# INLINE val #-}


------------------------------------------------------------------------------
instance Known Ordering GT where
    val _ = GT
    {-# INLINE val #-}
#endif


------------------------------------------------------------------------------
type instance LT :<> LT = LT
type instance LT :<> EQ = LT
type instance LT :<> GT = LT
type instance EQ :<> LT = LT
type instance EQ :<> EQ = EQ
type instance EQ :<> GT = GT
type instance GT :<> LT = GT
type instance GT :<> EQ = GT
type instance GT :<> GT = GT