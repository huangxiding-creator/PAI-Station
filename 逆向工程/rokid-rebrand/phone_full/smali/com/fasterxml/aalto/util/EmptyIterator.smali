.class public final Lcom/fasterxml/aalto/util/EmptyIterator;
.super Ljava/lang/Object;
.source "EmptyIterator.java"

# interfaces
.implements Ljava/util/Iterator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Ljava/util/Iterator<",
        "TT;>;"
    }
.end annotation


# static fields
.field static final sInstance:Lcom/fasterxml/aalto/util/EmptyIterator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/fasterxml/aalto/util/EmptyIterator<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 12
    new-instance v0, Lcom/fasterxml/aalto/util/EmptyIterator;

    invoke-direct {v0}, Lcom/fasterxml/aalto/util/EmptyIterator;-><init>()V

    sput-object v0, Lcom/fasterxml/aalto/util/EmptyIterator;->sInstance:Lcom/fasterxml/aalto/util/EmptyIterator;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 14
    .local p0, "this":Lcom/fasterxml/aalto/util/EmptyIterator;, "Lcom/fasterxml/aalto/util/EmptyIterator<TT;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getInstance()Lcom/fasterxml/aalto/util/EmptyIterator;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">()",
            "Lcom/fasterxml/aalto/util/EmptyIterator<",
            "TT;>;"
        }
    .end annotation

    .line 23
    sget-object v0, Lcom/fasterxml/aalto/util/EmptyIterator;->sInstance:Lcom/fasterxml/aalto/util/EmptyIterator;

    return-object v0
.end method


# virtual methods
.method public hasNext()Z
    .locals 1

    .line 27
    .local p0, "this":Lcom/fasterxml/aalto/util/EmptyIterator;, "Lcom/fasterxml/aalto/util/EmptyIterator<TT;>;"
    const/4 v0, 0x0

    return v0
.end method

.method public next()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    .line 31
    .local p0, "this":Lcom/fasterxml/aalto/util/EmptyIterator;, "Lcom/fasterxml/aalto/util/EmptyIterator<TT;>;"
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0
.end method

.method public remove()V
    .locals 1

    .line 37
    .local p0, "this":Lcom/fasterxml/aalto/util/EmptyIterator;, "Lcom/fasterxml/aalto/util/EmptyIterator<TT;>;"
    new-instance v0, Ljava/lang/IllegalStateException;

    invoke-direct {v0}, Ljava/lang/IllegalStateException;-><init>()V

    throw v0
.end method
