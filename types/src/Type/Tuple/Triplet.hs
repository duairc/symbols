{-# LANGUAGE CPP #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE EmptyDataDecls #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE UndecidableInstances #-}

#ifdef DataPolyKinds
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE PolyKinds #-}
#endif

#ifdef SafeHaskell
{-# LANGUAGE Safe #-}
#endif

#include "kinds.h"

module Type.Tuple.Triplet
    ( Triplet
    , Fst
    , Snd
    , Trd
    )
where

#ifndef DataPolyKinds
-- base ----------------------------------------------------------------------
import           Data.Typeable (Typeable)


#endif
#ifndef DataPolyKinds
-- types ---------------------------------------------------------------------
import           Type.Bool ((:&&))
import           Type.Eq ((:==))
import           Type.Meta (Known, val, Proxy (Proxy))
import           Type.Ord (Compare)
import           Type.Semigroup ((:<>))


#endif
------------------------------------------------------------------------------
#ifdef DataPolyKinds
#if __GLASGOW_HASKELL__ >= 708
type Triplet = '(,,)
#else
type Triplet a b c = '(a, b, c)
#endif
#else
data Triplet a b c
  deriving (Typeable)


------------------------------------------------------------------------------
instance (Known ra a, Known rb b, Known rc c) =>
    Known (ra, rb, rc) (Triplet a b c)
  where
    val _ = (val (Proxy :: Proxy a), val (Proxy :: Proxy b),
        val (Proxy :: Proxy c))


------------------------------------------------------------------------------
type instance Triplet a b c :== Triplet a' b' c' =
    a :== a' :&& b :== b' :&& c :== c'


------------------------------------------------------------------------------
type instance Compare (Triplet a b c) (Triplet a' b' c')
    = Compare a a' :<> Compare b b' :<> Compare c c'


------------------------------------------------------------------------------
type instance Triplet a b c :<> Triplet a' b' c'
    = Triplet (a :<> a') (b :<> b') (c :<> c')
#endif


------------------------------------------------------------------------------
type family Fst (p :: KTriplet (KPoly1, KPoly2, KPoly3)) :: KPoly1
#ifdef ClosedTypeFamilies
  where
#else
type instance
#endif
    Fst (Triplet a _b _c) = a


------------------------------------------------------------------------------
type family Snd (p :: KTriplet (KPoly1, KPoly2, KPoly3)) :: KPoly2
#ifdef ClosedTypeFamilies
  where
#else
type instance
#endif
    Snd (Triplet _a b _c) = b


------------------------------------------------------------------------------
type family Trd (p :: KTriplet (KPoly1, KPoly2, KPoly3)) :: KPoly3
#ifdef ClosedTypeFamilies
  where
#else
type instance
#endif
    Trd (Triplet _a _b c) = c