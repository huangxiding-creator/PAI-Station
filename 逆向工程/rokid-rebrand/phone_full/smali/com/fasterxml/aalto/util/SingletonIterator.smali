.class public final Lcom/fasterxml/aalto/util/SingletonIterator;
.super Ljava/lang/Object;
.source "SingletonIterator.java"

# interfaces
.implements Ljava/util/Iterator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/Iterator<",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field private _done:Z

.field private final _value:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 1
    .param p1, "value"    # Ljava/lang/String;

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 15
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/fasterxml/aalto/util/SingletonIterator;->_done:Z

    .line 18
    iput-object p1, p0, Lcom/fasterxml/aalto/util/SingletonIterator;->_value:Ljava/lang/String;

    .line 19
    return-void
.end method


# virtual methods
.method public hasNext()Z
    .locals 1

    .line 23
    iget-boolean v0, p0, Lcom/fasterxml/aalto/util/SingletonIterator;->_done:Z

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public bridge synthetic next()Ljava/lang/Object;
    .locals 1

    .line 10
    invoke-virtual {p0}, Lcom/fasterxml/aalto/util/SingletonIterator;->next()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public next()Ljava/lang/String;
    .locals 1

    .line 28
    iget-boolean v0, p0, Lcom/fasterxml/aalto/util/SingletonIterator;->_done:Z

    if-nez v0, :cond_0

    .line 31
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/fasterxml/aalto/util/SingletonIterator;->_done:Z

    .line 32
    iget-object v0, p0, Lcom/fasterxml/aalto/util/SingletonIterator;->_value:Ljava/lang/String;

    return-object v0

    .line 29
    :cond_0
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0
.end method

.method public remove()V
    .locals 1

    .line 37
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    invoke-direct {v0}, Ljava/lang/UnsupportedOperationException;-><init>()V

    throw v0
.end method
